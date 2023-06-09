import 'dart:convert';

import 'package:http/http.dart' as http;

// import 'auth';
import 'package:presensi_app/service/auth.dart';

// const String host = 'http://192.168.1.37:8000/';
// const String api = '${host}api/';
// String token = '';

jadwal({Map? body}) async {
  final response = await http.get(
    Uri.parse("${api}jadwal/${dataUser?['kelas_id'].toString()}"),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  print(response.body);
  print(response.headers);
  final data = jsonDecode(response.body);
  // var encodeFirst = json.encode(response.body);
  // var data = json.decode(encodeFirst);

  return data;
}
