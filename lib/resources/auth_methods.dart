import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/resources/storage_method.dart';
import 'package:instagram_flutter_clone/models/user_model.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// getting users datails
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("user").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // sign up of the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // register user
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        // user id
        final uid = userCredential.user!.uid;

        //add image to database
        String photoUrl = await StorageMethod()
            .uploadImageToStorage('ProfilePics', file, false);

        // creating a user model

        model.User user = model.User(
            email: email,
            uid: uid,
            photoUrl: photoUrl,
            username: username,
            bio: bio,
            followers: [],
            following: []);

        // add user to firestore
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logging  in the  User

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please Enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// signing out user
  Future<void> signOut() async {
    _auth.signOut();
  }
}
