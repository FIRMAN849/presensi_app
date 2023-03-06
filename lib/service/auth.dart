import 'dart:convert';

import 'package:http/http.dart' as http;

const String host = 'http://192.168.43.168:8000/';
const String api = '${host}api/';
String token = '';

login({Map? body}) async {
  final response = await http.post(Uri.parse("${api}login"), body: body);
  final data = jsonDecode(response.body);

  return data;
}

user({Map? body}) async {
  final response = await http.get(
    Uri.parse("${api}user"),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  final data = jsonDecode(response.body);
  /* var encodeFirst = json.encode(response.body);
  var data = json.decode(encodeFirst); */

  return data;
}
