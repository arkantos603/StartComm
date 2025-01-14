import 'package:flutter/material.dart';
import 'package:startcomm/features/sign_in/sign_in_state.dart';
import 'package:startcomm/services/auth_services.dart';
import 'package:startcomm/services/secure_storage.dart';

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
      const secureStorage = SecureStorageService();
      _changeState(SignInStateLoading());
      
    try{
      final user =await _service.signIn(

       email: email,
       password: password,
       );
       
       if(user.id != null){
        await secureStorage.write(
          key: 'CURRENT_USER',
          value: user.toJson(),
        );
       _changeState(SignInStateSuccess());
       } else {
         throw Exception();
       }

    } catch (e) {
      _changeState(SignInStateError(e.toString()));
    }

  }
}