import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inspireme/Views/Home.dart';
import 'package:inspireme/Views/login.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context , snapshot){
          if(snapshot.hasData){
            return HomeView();
          }else{
            return LoginView();
          }
        }),
      ),
    );
  }
}




















/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  //signup

  Future<User?> signUp(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  //signin
  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  //signout
  Future<void> signOut() => _auth.signOut();

  User? get currentUser => _auth.currentUser;


}
*/