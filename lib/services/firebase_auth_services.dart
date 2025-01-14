import 'package:firebase_auth/firebase_auth.dart';
import 'package:startcomm/common/models/user_model.dart';
import 'package:startcomm/services/auth_services.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;
  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(
          name: result.user!.displayName,
          empresa: result.user!.displayName,
          email: result.user!.email,
          id: result.user!.uid,
        );
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({
    String? name,
    String? empresa,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_auth.currentUser != null) {
        await result.user!.updateDisplayName(name);
        await result.user!.updateDisplayName(empresa); //TALVEZ
        return UserModel(
          name: _auth.currentUser?.displayName,
          empresa: _auth.currentUser?.displayName,
          email: _auth.currentUser?.email,
          id: _auth.currentUser?.uid,
        );
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }
}
