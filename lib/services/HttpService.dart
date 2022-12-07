import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_app_flutter/services/IdentityService.dart';

class HttpService{
  final _url = 'https://taltech.akaver.com/api/v1';
  final _storage = new FlutterSecureStorage();
  final String _path;
  final identityService = new IdentityService();

  HttpService(this._path);

  Future<String> getAll() async {
    var jwt = await _storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }
    log(jwt);
    final response = await http.get(
      Uri.parse('$_url/$_path'),
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
    },);

    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      return response.body;
    } else if(response.statusCode == 401) {
      if (await identityService.refreshToken()) {
        return await getAll();
      } else {
        throw Exception('r');
      }
    } else {
      log(response.body);
            log(response.body);
      log(response.body);

      throw Exception('exep');
      return 'false';
    } 
  }

  Future<String> getById(String id) async {
    var jwt = await _storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }

    final response = await http.get(
      Uri.parse('$_url/$_path/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
    },);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if(response.statusCode == 401) {
      if (await identityService.refreshToken()) {
        return await getById(id);
      } else {
        throw Exception('r');
      }
    } else {
      throw Exception(response.body);
    } 
  }

    Future<String> add(String objectJson) async {
    var jwt = await _storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }
    final response = await http.post(
      Uri.parse('$_url/$_path'),
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
        'content-type': 'application/json'
      },
      body: objectJson,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else if(response.statusCode == 401) {
      if (await identityService.refreshToken()) {
        return await add(objectJson);
      } else {
        throw Exception('r');
      }
    }  else {
      log(response.statusCode.toString());
      log(response.body);
      throw Exception(response.body);
    } 
  }

  
  Future<String> put(String id, String objectJson) async {
    var jwt = await _storage.read(key: 'jwt');
    log('start');
    log(jwt.toString());
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }
    final response = await http.put(
      Uri.parse('$_url/$_path/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
        'content-type': 'application/json'
      },
      body: objectJson,
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return response.body;
    } else if(response.statusCode == 401) {
      if (await identityService.refreshToken()) {
        return await put(id, objectJson);
      } else {
        throw Exception('r');
      }
    } else {
      throw Exception(response.body);
    } 
  }


  Future<bool> delete(String id) async {
    var jwt = await _storage.read(key: 'jwt');
    if (jwt == null || jwt.isEmpty) {
      throw Exception('no Jwt');
    }
    
    final response = await http.delete(
      Uri.parse('$_url/$_path/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
    },);

    if (response.statusCode == 204 || response.statusCode == 200) {
        return true;
    } else if(response.statusCode == 401) {
      if (await identityService.refreshToken()) {
        return await delete(id);
      } else {
        throw Exception('r');
      }
    } else {
      log("HERE");
      log(response.statusCode.toString());
      log(response.body);
      throw Exception([response.body]);
    } 
  }
}