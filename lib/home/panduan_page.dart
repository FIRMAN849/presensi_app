import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presensi_app/home/profile_page.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';
import 'package:getwidget/getwidget.dart';

class PanduanPage extends StatefulWidget {
  const PanduanPage({super.key});

  @override
  State<PanduanPage> createState() => _panduanPageState();
}

class _panduanPageState extends State<PanduanPage> {
  Widget header() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/mainuser');
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: primaryTextColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Panduan',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget presensi() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          GFAccordion(
            title: 'Cara Presensi',
            content: '1. Masuk ke menu presensi\n'
                '2. klik button scan qr\n'
                '3. arahkan scanner ke qr code\n',
          )
        ],
      ),
    );
  }

  Widget izin() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          GFAccordion(
            title: 'Cara Izin',
            content: '1. Masuk ke menu izin\n'
                '2. isikan form yang tersedia\n'
                '3. kemudian klik kirim\n'
                '4. Admin akan memproses data izin',
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              presensi(),
              izin(),
            ],
          ),
        ),
      ),
    );
  }
}
