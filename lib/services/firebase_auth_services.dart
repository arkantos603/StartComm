import 'package:firebase_auth/firebase_auth.dart';
import 'package:startcomm/common/models/user_model.dart';
import 'package:startcomm/services/auth_services.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: name ?? '',
    );
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName ?? '',
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isAuthenticated() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }
}