import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  //initialize auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  //sign in
  Future<UserCredential> signIn(String email, String password) async{
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }

    
  }

  //sign up

  //sign out

  //errors
}