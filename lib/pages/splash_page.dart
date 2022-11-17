// ignore_for_file: unnecessary_const, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:presensi_app/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState

    Timer(
      const Duration(seconds: 3),
      // ignore: unnecessary_this
      () => Navigator.pushNamed(this.context, '/sign-in'),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Center(
        child: Image.asset(
          'assets/image_splashpage.png',
          height: 74,
        ),
      ),
    );
  }
}
