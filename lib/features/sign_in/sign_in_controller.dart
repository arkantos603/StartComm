import 'package:flutter/material.dart';
import 'package:startcomm/features/sign_in/sign_in_state.dart';
import 'package:startcomm/services/auth_services/auth_services.dart';

class SignInController extends ChangeNotifier {
  final AuthService _service;

  SignInController(this._service);

  SignInState _state = SignInStateInitial();

  SignInState get state => _state;

  void _changeState(SignInState newState) {
    _state = newState;
    notifyListeners();
  }

Future<void> signIn({
    required String email,
    required String password,
    }) async {
      _changeState(SignInStateLoading());
      
    try{
      await _service.signIn(

       email: email,
       password: password,
       );

    _changeState(SignInStateSuccess());
    } catch (e) {
      _changeState(SignInStateError(e.toString()));
    }

  }
}