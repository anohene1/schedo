import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crypto/crypto.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookAuth facebookSignIn = FacebookAuth.instance;
  TwitterLogin twitterSignIn = TwitterLogin(consumerKey: 'UaOn42PIXpOLXCxAYEw5Ikx1e', consumerSecret: 'T5nhBXZIllW7b287PeshW4QE5O2Tdq2S4irQiROYA5DOeiRvAH');

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await firebaseAuth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final AccessToken result = await facebookSignIn.login();

    final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.token);

    return await firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  String generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Future<UserCredential> signInWithApple() async {
  //   final rawNonce = generateNonce();
  //   final nonce = sha256ofString(rawNonce);
  //
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName], nonce: nonce);
  //
  //   final oauthCredential = OAuthProvider('apple.com').credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);
  //   return await firebaseAuth.signInWithCredential(oauthCredential);
  // }

  Future<UserCredential> signInWithTwitter() async {
    final TwitterLoginResult result = await twitterSignIn.authorize();
    final TwitterSession twitterSession = result.session;
    final AuthCredential credential = TwitterAuthProvider.credential(accessToken: twitterSession.token, secret: twitterSession.secret);
    return await firebaseAuth.signInWithCredential(credential);
  }
}