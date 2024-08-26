import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAuthentication? googleSignInAuthentication;
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication!.accessToken,
          idToken: googleSignInAuthentication!.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  Future<bool> signOut() async {
    await _auth.signOut().whenComplete(() async {
      await googleSignIn.signOut().then((result) async {
        if (result != null) {
          log('result :$result');
          return false;
        }
        return true;
      }, onError: (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        return false;
      });
    });
    return true;
  }
}
