// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/theme.dart';

import 'package:image_picker/image_picker.dart';

const List<String> list = <String>['Laki-Laki', 'Perempuan'];

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

@override
class _editProfileState extends State<editProfile> {
  TextEditingController dateController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController password = TextEditingController();

  Map dataUser = {};
  bool showPasssword = false;

  getUser() async {
    Map res = await user();
    setState(() {
      dataUser = res['data'];
      dateController.text = dataUser['tgl_lahir'] ?? '';
      email.text = dataUser['email'] ?? '';
      alamat.text = dataUser['alamat'] ?? '';
      // password.text = dataUser['password'] ?? '';
    });
    print(res['data']);
  }

  updateProfile() async {
    var bd = {
      'tgl_lahir': dateController.text,
      'email': email.text,
      'alamat': alamat.text,
    };
    // ignore: unused_local_variable
    var res = await update(update: File(image!.path), dd: bd);
    if (res['meta']['code'] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            'Berhasil Edit Profile',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            'Gagal Edit Profile',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void initState() {
    getUser();
    super.initState();
    dateController.text = "";
    password.text = dataUser['password'] ?? '';
  }

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
                'Edit Profile',
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

    Widget inputTanggal() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Lahir',
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
                    Icon(
                      Icons.calendar_month_rounded,
                      color: secondaryTextColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: dateController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Tanggal Lahir',
                          hintStyle: secondaryTextStyle,
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (pickeddate != null) {
                            String formattedDate =
                                DateFormat("dd-MM-yyyy").format(pickeddate);
                            setState(() {
                              dateController.text = formattedDate.toString();
                            });
                          }
                        },
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

    Widget inputEmail() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
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
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: email,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Email',
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

    Widget inputAlamat() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
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
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: alamat,
                        maxLines: 5,
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Alamat',
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

    Widget inputGambar() {
      // ignore: avoid_unnecessary_containers
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                myAlert();
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Upload Foto Profile',
                style: whiteTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semibold,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            image != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        //to show image, you type like this.
                        File(image!.path),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  )
                : Text(
                    "No Image",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  )
          ],
        ),
      );
    }

    // Widget inputPassword() {
    //   return Container(
    //     margin: const EdgeInsets.only(top: 20),
    //     child: Column(
    //       children: [
    //         Container(
    //           height: 50,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           decoration: BoxDecoration(
    //             color: bgWhite,
    //             borderRadius: BorderRadius.circular(10),
    //             border: Border.all(
    //               color: secondaryTextColor,
    //             ),
    //           ),
    //           child: Center(
    //             child: Row(
    //               children: [
    //                 Image.asset(
    //                   'assets/icon_password.png',
    //                   width: 16,
    //                 ),
    //                 const SizedBox(
    //                   width: 16,
    //                 ),
    //                 Expanded(
    //                   child: TextFormField(
    //                     style: primaryTextStyle,
    //                     controller: password,
    //                     obscureText: showPasssword,
    //                     decoration: InputDecoration.collapsed(
    //                       hintText: 'Password',
    //                       hintStyle: secondaryTextStyle,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 10,
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       showPasssword = !showPasssword;
    //                     });
    //                   },
    //                   child: Container(
    //                       child: !showPasssword
    //                           ? const Icon(Icons.visibility)
    //                           : const Icon(Icons.visibility_off)),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget kirim() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: TextButton(
          onPressed: () {
            updateProfile();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Upload',
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
              inputTanggal(),
              inputEmail(),
              inputAlamat(),
              inputGambar(),
              // inputPassword(),
              kirim(),
            ],
          ),
        ),
      ),
    );
  }
}
