class AuthState {
  bool _isLoggedIn = false;

  void set(bool state) {
    _isLoggedIn = state;
  }

  bool get() {
    return _isLoggedIn;
  }
}