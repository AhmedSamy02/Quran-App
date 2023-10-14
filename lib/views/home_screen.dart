import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:quran_app/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      openRatio: 0.6,
      openScale: 0.6,
      drawer: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerTop(),
            const Spacer(),
            drawerRow(
              Icons.star_half_outlined,
              'Rate Us',
              () {
                //TODO: Implement the rating
              },
            ),
            drawerRow(
              Icons.mail,
              'Contact Us',
              () {
                //TODO: Implement contacting
              },
            ),
            drawerRow(
              Icons.info,
              'About Us',
              () {
                //TODO: Navigate to About us screen
              },
            ),
            drawerRow(
              Icons.settings_outlined,
              'Settings',
              () {
                //TODO: Navigate to settings screen
              },
            ),
            const Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
      backdrop: Image.asset(
        'assets/images/app_background.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      child: Stack(
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
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 136.0),
                            child: Image.asset(
                              'assets/images/home_quran.png',
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                //TODO Implement going to bookmark
                              },
                              child: WideCard()),
                        ],
                      ),
                    ),
                    Expanded(
                      child: HomeGrid(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding drawerRow(IconData icon, String text, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white60,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeGrid extends StatelessWidget {
  HomeGrid({
    super.key,
  });
  final List<String> arabicGridTitles = [
    'سورة',
    'جزء',
    'سورة يس',
    'اّيت الكرسي',
  ];
  final List<String> englishGridTitles = [
    'Surah',
    'Juz',
    'Surah Yasin',
    'Ait Al-kursi',
  ];
  final List<Function> onPressedFunction = [
    (context) {
      Navigator.pushNamed(context, kSurAndJuzScreen, arguments: 0);
    },
    (context) {
      Navigator.pushNamed(context, kSurAndJuzScreen, arguments: 1);
    },
    (context) {
      //TODO: Implement the Suret Yasin screen navigation
    },
    (context) {
      //TODO: Implement the Ayit Kursi screen navigation
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 28),
      itemCount: 4,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 50.0,
        mainAxisSpacing: 40.0,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onPressedFunction[index](context),
          child: HomeGridItem(
            arabicGridTitle: arabicGridTitles[index],
            englishGridTitle: englishGridTitles[index],
          ),
        );
      },
    );
  }
}

class HomeGridItem extends StatelessWidget {
  const HomeGridItem({
    super.key,
    required this.arabicGridTitle,
    required this.englishGridTitle,
  });

  final String arabicGridTitle;
  final String englishGridTitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/card_background.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  arabicGridTitle,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  englishGridTitle,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.white70),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipOval(
                child: Container(
                  color: kHomeScreenButtonColor,
                  width: 30,
                  height: 30,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white60,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WideCard extends StatelessWidget {
  const WideCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: const DecorationImage(
          image: AssetImage('assets/images/wide_card_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      width: double.infinity,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/basmala.png'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_book_sharp,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Last Read',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Al-Fatiah',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Ayah No:1',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                Image.asset('assets/vectors/bookmark.png')
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrawerTop extends StatelessWidget {
  const DrawerTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset(
          'assets/images/drawer_quran.png',
          height: 250,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 14.0),
          child: Column(
            children: [
              Text(
                'Quran kareem',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'With Multiple Translilation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
