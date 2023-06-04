import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'auth.dart';

const String api = '${host}api/';
String token = '';

postIzin({required File izin, Map? dd}) async {
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };

  log('message: $dd');
  try {
    var res = http.MultipartRequest('POST', Uri.parse("${api}izin"));
    res.headers.addAll(headers);
    log('here');

    if (izin != null) {
      var pickIzin = await http.MultipartFile.fromPath("image", izin.path);
      res.files.add(pickIzin);
    }
    // log("mjymuuk", dd['nama']);
    print(izin.path);
    log('message: $res,   data: $res.fields');
    res.fields['siswa_id'] = dd!['siswa_id'].toString();
    res.fields['kelas_id'] = dd['kelas_id'].toString();
    res.fields['tgl_izin'] = dd['tgl_izin'];
    res.fields['alasan'] = dd['alasan'];
    res.fields['keterangan'] = dd['keterangan'];

    http.Response response = await http.Response.fromStream(await res.send());
    log('res: $response');
    final data = jsonDecode(response.body);

    return data;
  } catch (e) {
    print(e);
  }
}
