import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final _authInstance = FirebaseAuth.instance;

  String _email = "";
  String _password = "";

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    try {
      final authRes = await _authInstance.createUserWithEmailAndPassword(
          email: _email, password: _password);

      debugPrint(authRes.user?.refreshToken);
      debugPrint(authRes.user?.uid);
      _verifyEmail();
      const snackBar = SnackBar(
        content: Text("Register Successfully"),
        backgroundColor: Colors.green,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e.toString());
      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Can't Register because of : ${e.toString()}"),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      final authRes = await _authInstance.signInWithEmailAndPassword(
          email: _email, password: _password);

      debugPrint(authRes.user?.refreshToken);
      debugPrint(authRes.user?.uid);
      const snackBar = SnackBar(
        content: Text("Login Successfully"),
        backgroundColor: Colors.green,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e.toString());
      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Can't Login because of : ${e.toString()}"),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await _authInstance.sendPasswordResetEmail(email: _email);

      const snackBar = SnackBar(
        content: Text("Reset Password Successfully"),
        backgroundColor: Colors.green,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e.toString());
      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Can't Reset Password because of : ${e.toString()}"),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> _verifyEmail() async {
    try {
      final user = _authInstance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    // SignIn with Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    // Get the Auth Results after sign in
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential from information come from auth in the previous step
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    // Sign in to firebase with credential that come form the google
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
