import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/screens/NGOsScreen/NGOProfile.dart';

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

  Future<String> signInUser(
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

  Future<String> signInNGOs(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed In");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NGOProfileScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  Future<String> signUpUser(
      {String email,
      String password,
      String firstname,
      String lastname,
      String imgUrl,
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
        'imgUrl': imgUrl,
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

  Future<String> signUpNGOs(
      {String email,
      String password,
      String orgname,
      String size,
      BuildContext context}) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User newUser = authResult.user;
      await _firestore.collection('ngo').doc(newUser.uid).set({
        'id': newUser.uid,
        'orgName': orgname,
        'size': size,
        'email': email,
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NGOProfileScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  Future<String> uploadImageToFirebase(img) async {
    final String fileName = DateTime.now().microsecond.toString();
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('userPics/$fileName');
    final UploadTask uploadTask = firebaseStorageRef.putFile(img);
    String url;
    await uploadTask.whenComplete(() async {
      url = await uploadTask.snapshot.ref.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }
}
