import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FlutterFireAuthService(this._firebaseAuth);
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  String _getUserId() {
    final user = _firebaseAuth.currentUser;
    final userId = user.uid;
    return userId;
  }

  //Authen Functions
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed In");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  Future<String> signUp(
      {String email,
      String password,
      String firstname,
      String lastname,
      BuildContext context}) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User newUser = authResult.user;
      await _firestore.collection('general_user').doc(newUser.uid).set({
        'id': newUser.uid,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }
}
