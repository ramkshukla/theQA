import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleAuthRepository {
  Future<UserCredential> signInWithGoogle();
}

class GoogleAuthRepositoryImpl extends GoogleAuthRepository {
  Completer<UserCredential> completer = Completer();

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    completer.complete(FirebaseAuth.instance.signInWithCredential(credential));

    return completer.future;
  }
}
