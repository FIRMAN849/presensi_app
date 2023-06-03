import 'package:flutter/material.dart';
import 'package:presensi_app/main.dart';
import 'package:presensi_app/theme.dart';

import '../service/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    sigIn() async {
      if (username.text.isNotEmpty && pass.text.isNotEmpty) {
        var bd = {'username': username.text, 'password': pass.text};
        Map res = await login(body: bd);
        print(res);
        if (res['meta']['code'] == 200) {
          Map dp = res['data'];
          token = res['data']['access_token'];
          dataUser = dp;
          if (dp['role'] == 'user') {
            Navigator.of(GlobalVariable.navState.currentContext!)
                .pushNamedAndRemoveUntil('/mainuser', (route) => false);
          }
          if (dp['role'] == 'other') {
            Navigator.of(GlobalVariable.navState.currentContext!)
                .pushNamedAndRemoveUntil('/mainother', (route) => false);
          }
        } else {
          ScaffoldMessenger.of(GlobalVariable.navState.currentContext!)
              .showSnackBar(
            SnackBar(
              backgroundColor: primaryColor,
              content: Text(
                res['meta']['message'],
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(GlobalVariable.navState.currentContext!)
            .showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: Text(
              'Username / Password Tidak boleh kosong!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

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
          ],
        ),
      );
    }

    Widget imgBanner() {
      return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Image.asset(
              'assets/image_banner_login.png',
              height: 250,
              width: 340,
            ),
          ],
        ),
      );
    }

    Widget textLogin() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            Text(
              'please enter your account',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    Widget inputUsername() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
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
                      'assets/icon_user.png',
                      width: 16,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: username,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Username',
                          hintStyle: secondaryTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputPassword() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
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
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Password',
                          hintStyle: secondaryTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget forgotPassword() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'forgotpassword',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }

    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: TextButton(
          onPressed: () {
            sigIn();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Login',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              imgBanner(),
              textLogin(),
              inputUsername(),
              inputPassword(),
              forgotPassword(),
              signInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
