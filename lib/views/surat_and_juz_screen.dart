import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:quran_app/constants.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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
                            child: FutureBuilder(
                                future: ApiServices.futureGetSurat,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                        height: 2,
                                        thickness: 1,
                                        color: Colors.white12,
                                      ),
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        var data = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: SurListItem(data: data),
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                        child: SpinKitThreeBounce(
                                      color: Colors.blue[800],
                                    ));
                                  }
                                }),
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
}

class SurListItem extends StatelessWidget {
  const SurListItem({
    super.key,
    required this.data,
  });

  final Sura data;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
