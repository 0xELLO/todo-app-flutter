import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService{
  final url = 'https://taltech.akaver.com/api/v1';
  final storage = new FlutterSecureStorage();
  final String path;

  HttpService(this.path);

  Future<String> getAll() async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }

    final response = await http.get(
      Uri.parse('$url/$path'),
      headers: <String, String>{
        'Bearer': jwt
    },);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    } 
  }

  Future<String> getById(String id) async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }

    final response = await http.get(
      Uri.parse('$url/$path/$id'),
      headers: <String, String>{
        'Bearer': jwt
    },);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    } 
  }

    Future<String> post(String objectJson) async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }
    final response = await http.post(
      Uri.parse('$url/$path'),
      headers: <String, String>{
        'Bearer': jwt
      },
      body: objectJson,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    } 
  }

  
  Future<String> put(String id, String objectJson) async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }
    final response = await http.put(
      Uri.parse('$url/$path/$id'),
      headers: <String, String>{
        'Bearer': jwt
      },
      body: objectJson,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    } 
  }


  Future<String> delete(String id) async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }
    
    final response = await http.delete(
      Uri.parse('$url/$path/$id'),
      headers: <String, String>{
        'Bearer': jwt
    },);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    } 
  }
}