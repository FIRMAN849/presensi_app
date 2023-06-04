import 'dart:io';

import 'package:flutter/material.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/service/izin.dart';
import 'package:presensi_app/theme.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class izinPage extends StatefulWidget {
  const izinPage({super.key});

  @override
  State<izinPage> createState() => _izinPageState();
}

@override
class _izinPageState extends State<izinPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController alasan = TextEditingController();

  bool loading = false;

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
                    child: Row(
                      children: const [
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
                    child: Row(
                      children: const [
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

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  createIzin() async {
    setState(() {
      loading = true;
    });
    var bd = {
      'siswa_id': dataUser!['siswa_id'],
      'kelas_id': dataUser!['kelas_id'],
      'tgl_izin': dateController.text,
      'keterangan': selectedValue,
      'alasan': alasan.text,
    };
    Map res = await postIzin(izin: File(image!.path), dd: bd);
    print(res);
    if (res['meta']['code'] == 200) {
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
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
                'Izin',
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

    Widget inputStatus() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: bgWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: secondaryTextColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton(
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: ["SAKIT", "IZIN"]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList()),
            ),
          ],
        ),
      );
    }

    Widget inputTanggal() {
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
                          hintText: 'Tanggal',
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
                'Upload Image',
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
                      borderRadius: BorderRadius.circular(8),
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

    Widget inputKeterangan() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
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
                        maxLines: 5,
                        controller: alasan,
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Alasan',
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

    Widget kirim() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: TextButton(
          onPressed: () {
            createIzin();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Kirim',
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
            children: [
              header(),
              inputStatus(),
              inputTanggal(),
              inputGambar(),
              inputKeterangan(),
              loading
                  ? Container(
                      margin: const EdgeInsets.only(top: 14),
                      child: const Center(
                        child: LinearProgressIndicator(),
                      ),
                    )
                  : kirim(),
            ],
          ),
        ),
      ),
    );
  }
}
