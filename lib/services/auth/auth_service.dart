import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  //initialize auth
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //sign in
  Future<UserCredential> signIn(String email, String password) async{
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      //create document for user if it doesn't exist
      firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            "uid": userCredential.user!.uid,
            "email": email,
            "createdAt": DateTime.now()
          }
      );
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUp(String email, String password) async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      //create document for user
      firestore.collection("users").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
          "createdAt": DateTime.now()
        }
      );

      return userCredential;
    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async{
    return await auth.signOut();

  }

  //errors
}