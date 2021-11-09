import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireUser {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = "";
  String displayName = "";

  FireUser() {
    uid = auth.currentUser.uid;
    firestore
        .collection("users")
        .doc(uid)
        .get()
        .then((value) => displayName = value.get("displayName").toString());
  }
}
