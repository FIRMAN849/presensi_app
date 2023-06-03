import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/home/myprofile_page.dart';
import 'package:presensi_app/home/profile_page.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';

import 'package:image_picker/image_picker.dart';

class editPassword extends StatefulWidget {
  const editPassword({super.key});

  @override
  State<editPassword> createState() => _editPasswordState();
}

@override
class _editPasswordState extends State<editPassword> {
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();

  bool showPasssword = false;

  create() async {
    if (currentpassword.text.isNotEmpty && newpassword.text.isNotEmpty) {
      var bd = {
        'current_password': currentpassword.text,
        'new_password': newpassword.text,
      };
      Map res = await ubahpassword(body: bd);
      print(res);
      if (res['meta']['code'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Berhasil Ubah Password',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Password Lama tidak sesuai',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  void initState() {
    create();
    super.initState();
  }

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
              'Edit Password',
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

  Widget currentPassword() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Lama',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: bgWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: secondaryTextColor,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_password.png',
                    width: 16,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: currentpassword,
                      obscureText: showPasssword,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Current Password',
                        hintStyle: secondaryTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showPasssword = !showPasssword;
                      });
                    },
                    child: Container(
                        child: !showPasssword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newPassword() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Baru',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: bgWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: secondaryTextColor,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_password.png',
                    width: 16,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: newpassword,
                      obscureText: showPasssword,
                      decoration: InputDecoration.collapsed(
                        hintText: 'New Password',
                        hintStyle: secondaryTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showPasssword = !showPasssword;
                      });
                    },
                    child: Container(
                        child: !showPasssword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget kirim() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: () {
          if (currentpassword.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: primaryColor,
                content: const Text(
                  'Password Lama tidak boleh kosong',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (newpassword.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: primaryColor,
                content: const Text(
                  'Password Baru tidak boleh kosong',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (newpassword.text == currentpassword.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: primaryColor,
                content: const Text(
                  'Password Baru tidak boleh sama',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (newpassword.text.length < 5) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: primaryColor,
                content: const Text(
                  'Password Baru minimal 5',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            create();
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Send',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 16,
          ),
        ),
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
              currentPassword(),
              newPassword(),
              kirim(),
            ],
          ),
        ),
      ),
    );
  }
}
