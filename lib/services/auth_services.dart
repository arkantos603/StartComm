import 'package:startcomm/common/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> signUp({
    String? name,
    String? empresa,
    required String email,
    required String password,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });
}
//   Future<void> signOut();

//   Future<String> userToken();

//   Future<bool> forgotPassword(String email);
// }

// Future signIn(),
