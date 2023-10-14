import 'package:flutter/material.dart';

class SuratAndJuzScreen extends StatefulWidget {
  const SuratAndJuzScreen({super.key});

  @override
  State<SuratAndJuzScreen> createState() => _SuratAndJuzScreenState();
}

class _SuratAndJuzScreenState extends State<SuratAndJuzScreen> {
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
                    child: Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(
                              child: Text('Surah'),
                            ),
                            Tab(
                              child: Text('Surah'),
                            ),
                          ],
                        ),
                        TabBarView(
                          children: [
                            Placeholder(),
                            Placeholder(),
                          ],
                        ),
                      ],
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
