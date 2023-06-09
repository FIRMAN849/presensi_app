import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';
import 'package:presensi_app/service/riwayat.dart';

class RiwayatIzin extends StatefulWidget {
  const RiwayatIzin({super.key});
  @override
  State<RiwayatIzin> createState() => _RiwayatIzinState();
}

class _RiwayatIzinState extends State<RiwayatIzin> {
  // Map dataUser = {};
  List dataIzin = [];

  getIzin() async {
    Map res = await riwayatizin();
    setState(() {
      dataIzin = res['data'];
    });
    print(res['data']);
  }

  void initState() {
    super.initState();
    getIzin();
  }

  Widget build(BuildContext context) {
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
                'Riwayat Izin',
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

    Widget listIzin() {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dataIzin.length,
        itemBuilder: (context, index) {
          Map dd = dataIzin[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: Text(
                  dd['tgl_izin'],
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: regular),
                ),
                title: Text(
                  dd['keterangan'].toString(),
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dd['alasan'].toString(),
                      style: primaryTextStyle.copyWith(
                          fontSize: 13, fontWeight: regular),
                    ),
                    Text(
                      dd['status'].toString(),
                      style: primaryTextStyle.copyWith(
                          fontSize: 13, fontWeight: regular),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                listIzin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
