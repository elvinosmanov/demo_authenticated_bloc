import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:max_flutter_authentication/model/user.dart';

class AuthRepository {
  final firebase_user.FirebaseAuth _firebaseAuth;

  AuthRepository({firebase_user.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_user.FirebaseAuth.instance;

  var currentUser = User.empty;
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (_) {}
  }

  Future<void> logInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (_) {}
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }
}

extension on firebase_user.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email, photo: photoURL);
  }
}
