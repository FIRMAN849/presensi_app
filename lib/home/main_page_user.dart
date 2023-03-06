import 'package:flutter/material.dart';
import 'package:presensi_app/home/home_user.dart';
import 'package:presensi_app/home/profile_page.dart';
import 'package:presensi_app/theme.dart';

import '../service/auth.dart';

// ignore: camel_case_types
class mainUser extends StatefulWidget {
  const mainUser({super.key, required role});

  @override
  State<mainUser> createState() => _mainUserState();
}

class _mainUserState extends State<mainUser> {
  int currentIndex = 0;

  Map dataUser = {};
  getUser() async {
    Map res = await user();
    setState(() {
      dataUser = res['data'];
    });
    print(res['data']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedLabelStyle: TextStyle(
          color: secondaryTextColor,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_home.png',
              color: currentIndex == 0 ? primaryColor : const Color(0xffc7c7c7),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_user2.png',
              color: currentIndex == 1 ? primaryColor : const Color(0xffc7c7c7),
            ),
            label: '',
          ),
        ],
      );
    }

    /* Widget textUser() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Hello, ' + dataUser['nama'],
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      );
    } */

    Widget body() {
      switch (currentIndex) {
        case 0:
          return const homeUser();
          break;
        case 1:
          return const ProfilePage();
          break;
        default:
          return const homeUser();
      }
    }

    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      resizeToAvoidBottomInset: false,
      body: body(),
    );
  }
}
