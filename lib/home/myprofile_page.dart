import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';

class myProfile extends StatefulWidget {
  const myProfile({super.key});
  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
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
                'My Profile',
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
          children: [
            dataUser.isNotEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(dataUser['user']?['image'] ?? ''),
                    ),
                  )
                : SizedBox(
                    width: 50,
                  ),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Nama :',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          dataUser['user']?['nama'] ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'NIS :',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          dataUser['nis'] ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Gender :',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          dataUser['jenis_kelamin'] ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Kelas :',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          dataUser['kelas']?['nama_kelas'] ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'tgl lahir:',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          dataUser['tgl_lahir'] ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Alamat :',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          dataUser['alamat'] ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Email :',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          dataUser['email'] ?? '',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget edtiBtn() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/editprofile');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Edit Profile',
            style: whiteTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 16,
            ),
          ),
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
                biodata(),
                edtiBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
