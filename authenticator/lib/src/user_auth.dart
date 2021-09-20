import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  final auth = FirebaseAuth.instance;

  Future<String?> create(String email, String password) async {
    final u = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return u.user?.uid;
  }

  Future<String?> login(String email, String password) async {
    final u =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return u.user?.uid;
  }

  Stream<String?> get uidState =>
      auth.authStateChanges().map((event) => event?.uid);

  String get uid => auth.currentUser?.uid ?? '';

  bool get isUserAuthenticated => auth.currentUser?.uid != null;

  Future<void> logout() {
    return auth.signOut();
  }
}
