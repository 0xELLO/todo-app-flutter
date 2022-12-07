import 'package:flutter/cupertino.dart';
import 'package:todo_app_flutter/bll/AuthState.dart';
import 'package:todo_app_flutter/services/IdentityService.dart';

class AuthStateModel extends ChangeNotifier {
  final AuthState _authState = AuthState();

  AuthStateModel() {
    final identityService = IdentityService();
    identityService.refreshToken().then((value) => set(value));
    notifyListeners();
  }

  bool get value => _authState.get();

  void set(bool value) {
    _authState.set(value);
    notifyListeners();
  }

  void reset() {
    _authState.set(false);
    notifyListeners();
  }
}