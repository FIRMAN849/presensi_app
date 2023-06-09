import 'package:flutter/material.dart';
import 'package:presensi_app/home/editpassword_page.dart';
import 'package:presensi_app/home/editprofile_page.dart';
import 'package:presensi_app/home/izin_page.dart';
import 'package:presensi_app/home/jadwal_page.dart';
import 'package:presensi_app/home/main_page_user.dart';
import 'package:presensi_app/home/myprofile_page.dart';
import 'package:presensi_app/home/panduan_page.dart';
import 'package:presensi_app/home/riwayatizin.dart';
import 'package:presensi_app/home/riwayatpresensi.dart';
import 'package:presensi_app/pages/sign_in_page.dart';
import 'package:presensi_app/pages/splash_page.dart';

class GlobalVariable {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalVariable.navState,
      routes: {
        '/': (context) => const SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/mainuser': (context) => const mainUser(
              role: null,
            ),
        '/izinpage': (context) => const izinPage(),
        '/jadwalpage': (context) => const jadwalPage(
              role: null,
            ),
        '/editprofile': (context) => const editProfile(),
        '/editpassword': (context) => const editPassword(),
        '/myprofile': (context) => const myProfile(),
        '/panduan': (context) => const PanduanPage(),
        '/riwayatpresensi': (context) => const RiwayatPresensi(),
        '/riwayatizin': (context) => const RiwayatIzin(),
      },
    );
  }
}
