import 'package:startcomm/common/models/user_model.dart';
import 'package:startcomm/services/auth_services.dart';

class MockAuthService implements AuthService{
  @override
  Future <UserModel> signIn( {
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
        try{
          if(password.startsWith('123')) {
            throw Exception();
          }
          return UserModel(
            id: email.hashCode.toString(),
            email: email,
            password: password,
          );
        } catch (e) {
          if (password.startsWith('123')) {
            throw 'Erro ao logar, tente novamente.';
          }
          throw 'Não foi possível realizar login no momento, tente mais tarde.';
        }
  }

  // @override
  // Future<dynamic> signIn({required String email, required String password}) {
  //   throw UnimplementedError();
  // }

  // @override
  // Future<void> signOut() {
  //   throw UnimplementedError();
  // }

  @override
  Future<UserModel> signUp({
    String? name,
    String? empresa,
     required String email,
      required String password
      }) async {
          await Future.delayed(const Duration(seconds: 2));
        try{
          if(password.startsWith('123')) {
            throw Exception();
          }
          return UserModel(
            id: email.hashCode.toString(),
            name: name,
            empresa: empresa,
            email: email,
            password: password,
          );
        } catch (e) {
          if (password.startsWith('123')) {
            throw 'Senha fraca. Digite uma senha mais forte.';
          }
          throw 'Não foi possível criar a conta no momento.';
        }
      }
      
        // @override
        // Future<dynamic> forgotPassword(String email) {
        //   throw UnimplementedError();
        // }
      
        // @override
        // Future<dynamic> userToken() {
        //   throw UnimplementedError();
        // }


}