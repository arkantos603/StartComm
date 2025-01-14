import 'package:flutter/foundation.dart';
import 'package:startcomm/services/auth_services.dart';
import 'sign_up_state.dart';
import 'package:startcomm/services/secure_storage.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _service;
  SignUpController(this._service);

  SignUpState _state = SignUpStateInitial();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String empresa,
    required String email,
    required String password,
  }) async {
    final secureStorage = SecureStorageService();
    _changeState(SignUpStateLoading());

    try {
      final user = await _service.signUp(
        name: name,
        empresa: empresa,
        email: email,
        password: password,
      );
      if (user.id != null) {
        await secureStorage.write(
          key: 'CURRENT_USER', 
          value: user.toJson()
        );
        _changeState(SignUpStateSuccess());
      } else {
        throw Exception();
      }
    } catch (e) {
      _changeState(SignUpStateError(e.toString()));
    }
  }
}
