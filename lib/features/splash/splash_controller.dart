import 'package:flutter/foundation.dart';
import 'package:startcomm/services/secure_storage.dart';
import 'splash_state.dart';

class SplashController extends ChangeNotifier {
  final SecureStorage _secureStorage;

  SplashController(this._secureStorage);

  SplashState _state = SplashStateInitial();
  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> isUserLogged() async {
    debugPrint('SplashController: Checking if user is logged in');
    final result = await _secureStorage.readOne(key: "CURRENT_USER");
    if (result != null) {
      debugPrint('SplashController: User is logged in');
      _changeState(AuthenticatedUser());
    } else {
      debugPrint('SplashController: User is not logged in');
      _changeState(UnauthenticatedUser());
    }
  }
}