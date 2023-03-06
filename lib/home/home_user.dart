
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/theme.dart';
import 'package:presensi_app/utils/date_local.dart';

class homeUser extends StatelessWidget {
  const homeUser({super.key});

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    var day = DateFormat('EEEE').format(time);
    var dayLocal = formatHari(day);
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/image_logo.png',
              height: 45,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Hello Firman',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            Text(
              'X RPL 3',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      );
    }

    Widget banner() {
      return Container(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/image_banner.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 15,
              top: 23,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Panduan Aplikasi',
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'Baca buku panduan untuk mempermudah',
                    style: whiteTextStyle.copyWith(
                      fontSize: 8,
                      fontWeight: semibold,
                    ),
                  ),
                  Text(
                    'mempemudah menjalankan aplikasi',
                    style: whiteTextStyle.copyWith(
                      fontSize: 8,
                      fontWeight: semibold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(1),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Read Now',
                      style: whiteTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget textDate() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayLocal,
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            Text(
              '${time.day}-${time.month}-${time.year}',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    }

    Widget menu() {
      return SizedBox(
        height: 280,
        child: GridView.count(
          primary: false,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 1.20,
          children: <Widget>[
            Card(
              color: primaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  print('tapp');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.calendar_month,
                      size: 50,
                      color: whiteTextColor,
                    ),
                    Text(
                      'Absen',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: primaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  print('tapp');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.assignment,
                      size: 50,
                      color: whiteTextColor,
                    ),
                    Text(
                      'Jadwal',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: primaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  print('tapp');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 50,
                      color: whiteTextColor,
                    ),
                    Text(
                      'Riwayat',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: primaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/izinpage');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.mail,
                      size: 50,
                      color: whiteTextColor,
                    ),
                    Text(
                      'Izin',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
                banner(),
                textDate(),
                menu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
