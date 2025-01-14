import 'package:flutter/foundation.dart';
import 'package:startcomm/services/secure_storage.dart';
import 'splash_state.dart';

class SplashController extends ChangeNotifier {
  final SecureStorageService _service;

  SplashController(this._service);

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> isUserLogged() async {
    await Future.delayed(const Duration(seconds: 1));
    final result = await _service.readOne(key: "CURRENT_USER");
    if (result != null) {
      _changeState(SplashStateSuccess());
    } else {
      _changeState(SplashStateError());
    }
  }
}
