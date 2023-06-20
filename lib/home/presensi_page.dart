import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:presensi_app/main.dart';
import 'package:presensi_app/service/auth.dart';
import 'package:presensi_app/service/izin.dart';
import 'package:presensi_app/theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;
  bool loading = false;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     qrController!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     qrController!.resumeCamera();
  //   }
  // }

  Future<void> _getCurrentPosition() async {
    setState(() {
      loading = true;
    });
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      setState(() {
        loading = false;
      });
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ));
    sendPresensiData(position);
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AwesomeDialog(
        context: GlobalVariable.navState.currentContext!,
        dialogType: DialogType.warning,
        animType: AnimType.scale,
        title: 'Peringatan',
        desc: 'Perizinan Lokasi belum diizinkan!',
        btnOkOnPress: () {},
      ).show();
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        AwesomeDialog(
          context: GlobalVariable.navState.currentContext!,
          dialogType: DialogType.warning,
          animType: AnimType.scale,
          title: 'Peringatan',
          desc: 'Perizinan Lokasi belum diizinkan!',
          btnOkOnPress: () {},
        ).show();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      AwesomeDialog(
        context: GlobalVariable.navState.currentContext!,
        dialogType: DialogType.warning,
        animType: AnimType.scale,
        title: 'Peringatan',
        desc: 'Perizinan Lokasi belum diizinkan!',
        btnOkOnPress: () {},
      ).show();
      return false;
    }

    return true;
  }

  sendPresensiData(Position position) async {
    var bd = {
      'siswa_id': dataUser!['siswa_id'].toString(),
      'location': '${position.latitude},${position.longitude}',
      'jenis_absen': result!.code,
    };
    Map res = await sendPresensi(bd);
    print(res);
    if (res['meta']['code'] == 200) {
      setState(() {
        loading = false;
      });
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
    } else {
      setState(() {
        loading = false;
      });
      AwesomeDialog(
        context: GlobalVariable.navState.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error',
        desc: res['meta']['message'],
        btnOkOnPress: () {},
      ).show();
      // ScaffoldMessenger.of(GlobalVariable.navState.currentContext!)
      //     .showSnackBar(
      //   SnackBar(
      //     backgroundColor: primaryColor,
      //     content: Text(
      //       res['meta']['message'],
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // );
    }
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
    // getCurrentPosition();
    // getLocation();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handlePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: const Text(
          'Presensi',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      'Arahkan kamera ke qr code',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                Expanded(flex: 2, child: _buildQrView(context)),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Scan a code',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await qrController?.toggleFlash();
                                  setState(() {});
                                },
                                child: FutureBuilder(
                                  future: qrController?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    return const Text('Flash');
                                  },
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await qrController?.flipCamera();
                                  setState(() {});
                                },
                                child: FutureBuilder(
                                  future: qrController?.getCameraInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return Text(
                                          'Camera ${describeEnum(snapshot.data!)}');
                                    } else {
                                      return const Text('Camera back');
                                    }
                                  },
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          overlayColor: Colors.white,
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (!loading) {
        _getCurrentPosition();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
