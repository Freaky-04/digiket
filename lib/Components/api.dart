import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CallApi {
  final String _url = "http://10.0.2.2:8000/api/";
  var client = http.Client();
  postData(data, apiurl) async {
    var fullUrl = _url + apiurl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  Future<dynamic> getData(apiurl) async {
    var fullUrl = _url + apiurl;
    print(fullUrl);
    return await client.get(Uri.parse(fullUrl));
  }


  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}
