import 'dart:async';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // String? _accessToken;
  DateTime? _expiryDate;
  Timer? _timer;

  AuthProvider(this._expiryDate) {
    _startTokenExpiryTimer();
  }

//  String? get accessToken => _accessToken;
  bool get isTokenExpired => DateTime.now().isAfter(_expiryDate!);

  void updateToken(DateTime newExpiryDate) {
    // _accessToken = newToken;
    _expiryDate = newExpiryDate;
    _startTokenExpiryTimer();
    notifyListeners();
  }

  void _startTokenExpiryTimer() {
    _timer?.cancel();
    final timeUntilExpiry =
        _expiryDate!.difference(DateTime.now()).inMilliseconds;

    if (timeUntilExpiry > 0) {
      _timer = Timer(Duration(milliseconds: timeUntilExpiry), _onTokenExpired);
    } else {
      _onTokenExpired();
    }
  }

  void _onTokenExpired() {
    clearToken();
    notifyListeners();
  }

  void clearToken() {
    // _accessToken = null;
    _expiryDate = null;
    _timer?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
