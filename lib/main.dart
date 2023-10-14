import 'package:flutter/material.dart';
import 'package:quran_app/constants.dart';
import 'package:quran_app/views/home_screen.dart';
import 'package:quran_app/views/splash_screen.dart';
import 'package:quran_app/views/surat_and_juz_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: kHomeScreen,
      routes: {
        kSplashScreen: (context) => const SplashScreen(),
        kHomeScreen: (context) => const HomeScreen(),
        kSurAndJuzScreen: (context) => const SuratAndJuzScreen()
      },
      home: const SplashScreen(),
    );
  }
}
