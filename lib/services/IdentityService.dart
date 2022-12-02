import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_flutter/domain/IJwtResponce.dart';
import 'dart:developer';
class IdentityService{
  final url = 'https://taltech.akaver.com/api/v1/Account';
  final storage = new FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$url/Login'),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      }),
      headers: <String, String>{
        'content-type': 'application/json'
      }
    );
    if (response.statusCode == 200) {
        final jwtResponce = JwtResponse.fromJson(jsonDecode(response.body));
        await storage.write(key: 'jwt', value: jwtResponce.token);
        await storage.write(key: 'refreshToken', value: jwtResponce.refreshToken);
        return true;
    } else {
      log("ERROR");
      log(response.statusCode.toString());
      log(response.body);
      log("ERROR");
      return false;
    }
  }
}