import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

const String host = 'http://192.168.18.23:8000/';
const String api = '${host}api/';
String token = '';
Map? dataUser;

login({Map? body}) async {
  final response = await http.post(Uri.parse("${api}login"),
      headers: {'Accept': 'application/json'}, body: body);
  final data = jsonDecode(response.body);

  return data;
}

user({Map? body}) async {
  final response = await http.get(
    Uri.parse("${api}user"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  final data = jsonDecode(response.body);
  /* var encodeFirst = json.encode(response.body);
  var data = json.decode(encodeFirst); */

  return data;
}

ubahpassword({Map? body}) async {
  final response =
      await http.post(Uri.parse("${api}updatepassword/${dataUser?['id']}"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body);
  final data = jsonDecode(response.body);

  return data;
}

update({required File update, Map? dd}) async {
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };

  log('message: $dd');
  try {
    var res = http.MultipartRequest(
        'POST', Uri.parse("${api}updateprofile/${dataUser?['id']}"));
    res.headers.addAll(headers);
    log('here');

    if (update != null) {
      var pickupdate = await http.MultipartFile.fromPath("image", update.path);
      res.files.add(pickupdate);
    }
    // log("mjymuuk", dd['nama']);
    print(update.path);
    log('message: $res,   data: $res.fields');
    res.fields['tgl_lahir'] = dd?['tgl_lahir'];
    res.fields['email'] = dd?['email'];
    res.fields['alamat'] = dd?['alamat'];

    http.Response response = await http.Response.fromStream(await res.send());
    log('res: $response');
    final data = jsonDecode(response.body);

    return data;
  } catch (e) {
    print(e);
  }
}
