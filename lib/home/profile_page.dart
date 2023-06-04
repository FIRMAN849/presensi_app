import 'package:flutter/material.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _profilePageState();
}

class _profilePageState extends State<ProfilePage> {
  Map dataUser = {};

  getUser() async {
    Map res = await user();
    setState(() {
      dataUser = res['data'];
    });
    print(res['data']['user']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/myprofile');
        },
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              dataUser.isNotEmpty
                  ? Container(
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            NetworkImage(dataUser['user']?['image'] ?? ''),
                      ),
                    )
                  : const SizedBox(
                      width: 30,
                    ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
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
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      dataUser['nis'] ?? '',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                  Navigator.pushNamed(context, '/editprofile');
                },
                child: Text(
                  'Edit Profile',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semibold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editpassword');
                },
                child: Text(
                  'Edit Password',
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
                  // Navigator.pushNamed(context, '/panduan');
                  print('ppp');
                  ;
                },
                child: Text(
                  'Riwayat Izin',
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
                  Navigator.pushNamed(context, '/panduan');
                  ;
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
                  dataUser == null;
                  Navigator.pushNamed(context, '/');
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
