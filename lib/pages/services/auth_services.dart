import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<Object> login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    } catch(e) {
      return e;
    }
  }

  Future<Object> signUp(String name,String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
          'uid': user?.uid,
          'name': name,
          'email': email,
          'password': password,
        });
      });
      return "Signed Up";
    } catch(e) {
      return e;
    }
  }

  // current

  // User information

  static getProfileName() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser?.displayName != null) {
      return auth.currentUser?.displayName;
    } else {
      return "Username is not present !";
    }
  }

  static getProfileEmail() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser?.email != null) {
      return auth.currentUser?.email;
    } else {
      return "Email Address Error !";
    }
  }
}