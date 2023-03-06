import 'package:flutter/material.dart';
import 'package:presensi_app/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage(
                'assets/image_avatar.png',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Firman Rizky',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  'X RPL 3',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
                Text(
                  '990127851923',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 65,
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.create,
                    size: 24,
                  ),
                  color: primaryTextColor,
                  onPressed: () {
                    print('ppp');
                  },
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget menu() {
      return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  print('ppp');
                },
                child: Text(
                  'Panduan Aplikasi',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: secondaryTextColor,
              ),
              TextButton(
                onPressed: () {
                  print('ppp');
                },
                child: Text(
                  'Tentang',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: secondaryTextColor,
              ),
              TextButton(
                onPressed: () {
                  print('ppp');
                },
                child: Text(
                  'Logout',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
              ),
            ],
          ));
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              menu(),
            ],
          ),
        ),
      ),
    );
  }
}
