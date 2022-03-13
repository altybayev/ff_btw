import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BtwAppFirebaseUser {
  BtwAppFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

BtwAppFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BtwAppFirebaseUser> btwAppFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<BtwAppFirebaseUser>((user) => currentUser = BtwAppFirebaseUser(user));
