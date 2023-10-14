import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/constants.dart';
import 'package:quran_app/models/sura.dart';
import 'package:quran_app/services/api.services.dart';
import 'package:quran_app/views/surat_and_juz_screen.dart';

class AyatScreen extends StatefulWidget {
  const AyatScreen({super.key});

  @override
  State<AyatScreen> createState() => _AyatScreenState();
}

class _AyatScreenState extends State<AyatScreen> {
  bool initial = false;
  late Sura currentSura;
  bool started = false;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    if (!initial) {
      initial = true;
      currentSura = ModalRoute.of(context)?.settings.arguments as Sura;
      ApiServices.instance.getAyatBySura(currentSura.id);
    }

    return Stack(
      children: [
        Image.asset(
          'assets/images/home_background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
              child: Column(
                children: [
                  Expanded(
                    child: WideCard(
                      sura: currentSura,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FutureBuilder(
                      future: ApiServices.futureGetAyatBySura,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;
                          List playingStatusIcon = List.filled(
                              data.length, Icons.play_arrow_outlined);
                          return Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: ListView.separated(
                              itemCount: data.length,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                height: 2,
                                thickness: 1,
                                color: Colors.white12,
                              ),
                              itemBuilder: (context, index) {
                                IconData currIcon = Icons.play_arrow_outlined;
                                return Container(
                                  color: Colors.transparent,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                          elevation: 15,
                                          color: Colors.black38,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IdBadge(
                                                id: data[index].id.toString(),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        if (player.state ==
                                                            PlayerState
                                                                .playing) {
                                                          await player.stop();
                                                        }
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        Icons.stop_outlined,
                                                        color:
                                                            kSelectedTabColor,
                                                        size: 28,
                                                      )),
                                                  IconButton(
                                                      onPressed: () async {
                                                        await player
                                                            .setSourceUrl(
                                                                data[index]
                                                                    .audioUrl);
                                                        if (player.state ==
                                                            PlayerState
                                                                .playing) {
                                                          await player.pause();
                                                        } else {
                                                          await player.resume();
                                                        }
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        player.state !=
                                                                PlayerState
                                                                    .playing
                                                            ? Icons
                                                                .play_arrow_outlined
                                                            : Icons
                                                                .pause_outlined,
                                                        color:
                                                            kSelectedTabColor,
                                                        size: 28,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.bookmark_outline,
                                                        color:
                                                            kSelectedTabColor,
                                                        size: 28,
                                                      )),
                                                ],
                                              )
                                            ],
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 10, 10),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            data[index].text,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'Amiri',
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            data[index].translatedText.replaceAll(
                                                RegExp(
                                                    r'<sup foot_note=\d+>\d+</sup>'),
                                                ''),
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              letterSpacing: 1.5,
                                              fontFamily: '.SF UI Text',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const ListLoading();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class IdBadge extends StatelessWidget {
  const IdBadge({
    super.key,
    required this.id,
  });
  final String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: Container(
          width: 30,
          height: 30,
          // padding: EdgeInsets.all(8.0),
          color: kSelectedTabColor,
          child: Center(
            child: Text(
              id,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WideCard extends StatelessWidget {
  const WideCard({
    super.key,
    required this.sura,
  });
  final Sura sura;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 50,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          image: const DecorationImage(
            image: AssetImage('assets/images/ayat_wide_card.png'),
            fit: BoxFit.fill,
          ),
        ),
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/ayat_quran.png',
                opacity: const AlwaysStoppedAnimation(0.7),
              ),
              SizedBox(
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          sura.arabicName,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 140,
                        child: Text(
                          sura.translatedName,
                          // overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${sura.revelationPlace.toUpperCase()} ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Image.asset('assets/images/dot.png'),
                          Text(
                            ' ${sura.versesCount} VERSES',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
