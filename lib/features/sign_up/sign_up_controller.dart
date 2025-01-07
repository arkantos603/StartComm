import 'package:flutter/foundation.dart';
import 'package:startcomm/services/auth_services/auth_services.dart';
import 'sign_up_state.dart';

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
      _changeState(SignUpStateLoading());
      
    try{
      await _service.signUp(
       name: name,
       empresa: empresa,
       email: email,
       password: password,
       );

    _changeState(SignUpStateSuccess());
    } catch (e) {
      _changeState(SignUpStateError(e.toString()));
    }

  }
}
