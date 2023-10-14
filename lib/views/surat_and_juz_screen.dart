import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:quran_app/constants.dart';
import 'package:quran_app/models/juz.dart';
import 'package:quran_app/models/sura.dart';
import 'package:quran_app/services/api.services.dart';

class SuratAndJuzScreen extends StatefulWidget {
  const SuratAndJuzScreen({super.key});

  @override
  State<SuratAndJuzScreen> createState() => _SuratAndJuzScreenState();
}

class _SuratAndJuzScreenState extends State<SuratAndJuzScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServices.instance.getSurat();
    ApiServices.instance.getJuzs();
    _currentFutureValue.add(ApiServices.futureGetSurat!);
    _currentFutureValue.add(ApiServices.futureGetJuzs!);
  }

  bool initial = false;
  @override
  Widget build(BuildContext context) {
    if (!initial) {
      _currentSelection = ModalRoute.of(context)?.settings.arguments as int;
      if (_currentSelection == 1) swapColorsAndWeights();
      initial = true;
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
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/secondary_quran.png',
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(width: double.infinity, child: TabBar()),
                          Expanded(
                            child: SuratListView(
                                workingFutureService:
                                    _currentFutureValue[_currentSelection]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  MaterialSegmentedControl<int> TabBar() {
    return MaterialSegmentedControl(
      selectionIndex: _currentSelection,
      children: {
        0: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 2, color: tab1Color)),
          ),
          child: Text(
            'Surah',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: tab1Weight),
          ),
        ),
        1: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 2, color: tab2Color)),
          ),
          child: Text(
            'Juz',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: tab2Weight),
          ),
        ),
      },
      borderColor: Colors.transparent,
      selectedColor: Colors.transparent,
      unselectedColor: Colors.transparent,
      selectedTextStyle: TextStyle(color: kSelectedTabColor),
      unselectedTextStyle: TextStyle(color: Colors.white60),
      onSegmentTapped: (index) {
        swapColorsAndWeights();
        setState(() {
          _currentSelection = index;
        });
      },
    );
  }

  void swapColorsAndWeights() {
    var temp = tab1Color;
    tab1Color = tab2Color;
    tab2Color = temp;
    var tempWeight = tab1Weight;
    tab1Weight = tab2Weight;
    tab2Weight = tempWeight;
  }

  int _currentSelection = 0;
  Color tab1Color = kSelectedTabColor;
  Color tab2Color = Colors.white10;
  FontWeight tab1Weight = FontWeight.bold;
  FontWeight tab2Weight = FontWeight.normal;
  final List<Future<List>> _currentFutureValue = [];
}

class SuratListView extends StatelessWidget {
  const SuratListView({
    super.key,
    required this.workingFutureService,
  });
  final Future<List<dynamic>> workingFutureService;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: workingFutureService,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 2,
                thickness: 1,
                color: Colors.white12,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: _chooseListView(
                      workingFutureService == ApiServices.futureGetSurat
                          ? 0
                          : 1,
                      data[index]),
                );
              },
            );
          } else {
            return ListLoading();
          }
        });
  }

  Widget _chooseListView(int choosenIndex, dynamic data) {
    if (choosenIndex == 0 && data is Sura) {
      return SurListItem(data: data);
    } else if (choosenIndex == 1 && data is Juz) {
      return JuzListItem(data: data);
    }
    return Center(
      child: SpinKitThreeBounce(
        color: Colors.blue[800],
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitThreeBounce(
      color: Colors.blue[700],
    ),);
  }
}

class SurListItem extends StatelessWidget {
  const SurListItem({
    super.key,
    required this.data,
  });

  final Sura data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, kAyatScreen,arguments: data),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/muslim.png'),
                    Text(
                      data.id.toString(),
                      style: TextStyle(color: kSelectedTabColor, fontSize: 14),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.englishName,
                        style: TextStyle(
                            fontSize: 16,
                            color: kSelectedTabColor,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${data.revelationPlace.toUpperCase()} - ${data.versesCount} VERSES',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Text(
            data.arabicName,
            style: TextStyle(
                fontFamily: 'Amiri',
                fontWeight: FontWeight.normal,
                color: kSelectedTabColor,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}

class JuzListItem extends StatelessWidget {
  const JuzListItem({
    super.key,
    required this.data,
  });

  final Juz data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/muslim.png'),
                  Text(
                    data.id.toString(),
                    style: TextStyle(color: kSelectedTabColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        data.firstAyah,
                        maxLines: 2,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18,
                            color: kSelectedTabColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        data.lastAyah,
                        textDirection: TextDirection.rtl,
                        maxLines: 2,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
