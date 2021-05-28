import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trashhub/models/GeneralUser.dart';
import 'package:trashhub/screens/GeneralUserScreen/UserProfile.dart';
import 'package:trashhub/screens/NGOsScreen/NGOProfile.dart';
import 'package:trashhub/models/GeneralUser.dart';
import 'package:trashhub/models/NGO.dart';
import 'package:trashhub/models/Report.dart';

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

  Future<bool> isUser() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('general_user').doc(_getUserId()).get();
    return snapshot.data() != null;
  }

  Future<bool> isNGO() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('ngo').doc(_getUserId()).get();
    return snapshot.data() != null;
  }

  Future<void> increaseTotalReport() async {
    await _firestore.collection('general_user').doc(_getUserId()).update({
      'totalReport': FieldValue.increment(1),
    });
  }

  Future<String> createRequest(
    String imgUrl,
    String location,
    String description,
    BuildContext context,
  ) async {
    try {
      await _firestore.collection('report').add(
        {
          'create_by': _getUserId(),
          'imgUrl': imgUrl,
          'status': "waiting",
          'responsible_by': "",
          'create_date': FieldValue.serverTimestamp(),
          'description': description,
        },
      );
      await increaseTotalReport();
      return "Add Report Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  // GET Method
  Future<List<Report>> getUserReports() async {
    List<Report> reports = [];
    dynamic snapshots = await _firestore
        .collection('report')
        .where("create_by", isEqualTo: _getUserId())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        reports.add(Report(
          date: element.data()['create_date'],
          location: element.data()['location'],
          imgUrl: element.data()['imgUrl'],
          status: element.data()['status'],
          responsible_by: element.data()['responsible_by'],
          description: element.data()['description'],
        ));
      });
    });
  }

  Future<List<Report>> getWaitingReports() async {
    List<Report> reports = [];
    dynamic snapshots = await _firestore
        .collection('report')
        .where("status", isEqualTo: "waiting")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        reports.add(Report(
          date: element.data()['create_date'],
          location: element.data()['location'],
          imgUrl: element.data()['imgUrl'],
          status: element.data()['status'],
          responsible_by: element.data()['responsible_by'],
          description: element.data()['description'],
        ));
      });
    });
  }

  Future<GeneralUser> getGeneralUserInfo() async {
    GeneralUser userInfo;
    print(_getUserId());
    dynamic snapshot = await _firestore
        .collection('general_user')
        .doc(_getUserId())
        .get()
        .then((value) {
      userInfo = GeneralUser(
          firstname: value.data()['firstname'],
          lastname: value.data()['lastname'],
          totalReport: value.data()['totalReport'],
          imgUrl: value.data()['imgUrl']);
    });
    return userInfo;
  }

  Future<NGO> getNGOInfo() async {
    NGO ngo;
    print(_getUserId());
    dynamic snapshot = await _firestore
        .collection('ngo')
        .doc(_getUserId())
        .get()
        .then((value) {
      ngo = NGO(
        orgName: value.data()['orgName'],
        size: value.data()['size'],
        completeTask: value.data()['completeTask'],
        imgUrl: value.data()['imgUrl'],
        remainingTask: value.data()['remainingTask'],
      );
    });
    return ngo;
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
      if (await isUser()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(),
          ),
        );
        return "Success";
      } else {
        print('No user account');
        signOut();
        return "Invalid account";
      }
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
      if (await isNGO()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NGOProfileScreen(),
          ),
        );
        return "Success";
      } else {
        print("NOT NGO");
        signOut();
        return "Invalid Account";
      }
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
        'totalReport': 0,
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
      String imgUrl,
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
        'imgUrl': imgUrl,
        'completeTask': 0,
        'remainingTask': 0,
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
