import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

const String host = 'http://192.168.43.168:8000/';
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
    var pickIzin = await http.MultipartFile.fromPath("image", izin.path);
    res.files.add(pickIzin);
    // log("mjymuuk", dd['nama']);
    log('message: $res,   data: $res.fields');
    res.fields['nama'] = dd?['nama'];
    res.fields['kelas'] = dd?['kelas'];
    res.fields['tgl_izin'] = dd?['tgl_izin'];
    res.fields['alasan'] = dd?['alasan'];

    http.Response response = await http.Response.fromStream(await res.send());
    log('res: $response');
    final data = jsonDecode(response.body);

    return data;
  } catch (e) {
    print(e);
  }
}
