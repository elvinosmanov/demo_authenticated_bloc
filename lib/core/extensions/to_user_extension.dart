import 'package:max_flutter_authentication/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_user;


extension UserExtension on firebase_user.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email, photo: photoURL);
  }
}
