import 'dart:convert';

import 'package:http/http.dart' as http;

// import 'auth';
import 'package:presensi_app/service/auth.dart';

const String api = '${host}api/';

riwayatpresensi({Map? body}) async {
  final response = await http.get(
    Uri.parse("${api}presensi/history/${dataUser?['siswa_id']}"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );

  final data = jsonDecode(response.body);
  print(data);
  return data;
}

riwayatizin({Map? body}) async {
  final response = await http.get(
    Uri.parse("${api}izin/history/${dataUser?['siswa_id']}"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );

  final data = jsonDecode(response.body);
  print(data);
  return data;
}
