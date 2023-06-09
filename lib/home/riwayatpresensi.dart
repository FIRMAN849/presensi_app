import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';
import 'package:presensi_app/service/riwayat.dart';

class RiwayatPresensi extends StatefulWidget {
  const RiwayatPresensi({super.key});
  @override
  State<RiwayatPresensi> createState() => _RiwayatPresensiState();
}

class _RiwayatPresensiState extends State<RiwayatPresensi> {
  Map dataUser = {};
  List dataPresensi = [];

  getUser() async {
    Map res = await user();
    setState(() {
      dataUser = res['data'];
    });
    print(res['data']);
  }

  getPresensi() async {
    Map res = await riwayatpresensi();
    setState(() {
      dataPresensi = res['data'];
    });
    print(res['data']);
  }

  void initState() {
    super.initState();
    getPresensi();
    getUser();
  }

  @override
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
                'Riwayat Presensi',
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

    Widget listPresensi() {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dataPresensi.length,
        itemBuilder: (context, index) {
          Map dd = dataPresensi[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: Text(
                  dd['tgl_absen']
                      .toString()
                      .substring(0, dd['tgl_absen'].toString().length - 3),
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, fontWeight: regular),
                ),
                title: Text(
                  dd['jenis_absen'].toString(),
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                subtitle: Text(
                  dd['status'].toString(),
                  style: primaryTextStyle.copyWith(
                      fontSize: 13, fontWeight: regular),
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
                listPresensi(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
