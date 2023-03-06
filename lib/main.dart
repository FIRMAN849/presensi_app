import 'package:flutter/material.dart';
import 'package:presensi_app/home/izin_page.dart';
import 'package:presensi_app/home/main_page_user.dart';
import 'package:presensi_app/pages/sign_in_page.dart';
import 'package:presensi_app/pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/mainuser': (context) => const mainUser(
              role: null,
            ),
        '/izinpage': (context) => const izinPage(),
      },
    );
  }
}
