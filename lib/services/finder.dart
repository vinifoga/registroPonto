import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map> Finder(Uri url, String token) async{
  var response = await http.get(url, headers: {
    'Content-type': 'application/json',
    'Authorization': token
  });

  Map<String, dynamic> objectMap = jsonDecode(response.body.toString());
  return objectMap;
}