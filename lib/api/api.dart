// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  getReq(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error $response.statusCode");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  postReq(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("No Connection");
      }
    } catch (e) {
      return "false";
    }
  }

  postReqImage(String url, Map data, File file) async {
    var req = http.MultipartRequest("POST", Uri.parse(url));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipart = http.MultipartFile("file", stream, lenght,
        filename: basename(file.path));
    req.files.add(multipart);
    data.forEach((key, value) {
      req.fields[key] = value;
    });
    var myreq = await req.send();
    var response = await http.Response.fromStream(myreq);
    if (myreq.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myreq.statusCode}");
    }
  }
}
