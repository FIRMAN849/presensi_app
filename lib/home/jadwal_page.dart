import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/home/home_user.dart';
import 'package:presensi_app/home/profile_page.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';

import '../service/jadwal.dart';

class jadwalPage extends StatefulWidget {
  const jadwalPage({super.key, required role});

  @override
  State<jadwalPage> createState() => _jadwalPagerState();
}

class _jadwalPagerState extends State<jadwalPage> {
  Map dataUser = {};
  List dataJadwal = [];

  getUser() async {
    Map res = await user();
    setState(() {
      dataUser = res['data'];
    });
    print(res['data']);
  }

  getJadwal() async {
    Map res = await jadwal();
    setState(() {
      dataJadwal = res['data'];
    });
    print(res['data']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getJadwal();
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
              width: 80,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Jadwal',
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

    Widget biodata() {
      return Container(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              dataUser['user']?['nama'] ?? '',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            Text(
              dataUser['kelas']?['nama_kelas'] ?? '',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      );
    }

    Widget listjadwal() {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dataJadwal.length,
        itemBuilder: (context, index) {
          Map dd = dataJadwal[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Text(
                  dd['hari'],
                  style:
                      primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
                title: Text(
                  dd['mapel_id'],
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dd['guru_id'],
                      style: primaryTextStyle.copyWith(
                          fontSize: 13, fontWeight: regular),
                    ),
                    Row(
                      children: [
                        Text(
                          // DateFormat.Hm().format(dd['jam_awal']),
                          dd['jam_awal'].toString().substring(
                              0, dd['jam_awal'].toString().length - 3),
                          // DateTime.parse(dd['jam_awal']),
                          style: primaryTextStyle.copyWith(
                              fontSize: 13, fontWeight: regular),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('-'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          dd['jam_akhir'].toString().substring(
                              0, dd['jam_akhir'].toString().length - 3),
                          style: primaryTextStyle.copyWith(
                              fontSize: 13, fontWeight: regular),
                        ),
                      ],
                    )
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
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                biodata(),
                listjadwal(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
