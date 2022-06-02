import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyStorage with ChangeNotifier {
   final _storage = FlutterSecureStorage();

   final String _tokenKey = 'token';

  Future setToken(token) async =>
      await _storage.write(key: _tokenKey, value: token);
   Future<String?> getToken() async {
    await _storage.read(key: _tokenKey);
    notifyListeners();
  }
}
