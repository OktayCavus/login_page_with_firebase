import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future signInAnonymous() async {
    try {
      final result = await firebaseAuth.signInAnonymously();
      print(result.user!.uid);
      return result.user;
    } catch (e) {
      print('Anon error ${e.toString()}');
      return null;
    }
  }

  Future forgotPassword(String email) async {
    try {
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
      print('Mail kutunuzu kontrol ediniz');
    } catch (e) {}
  }

// * BU YAPI STRİNG BİR METHOD DÖNSÜN
  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      // ! burdaki kodları firebase hata kodları diye bakarak bulunabilir
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/User/reauthenticateWithCredential.html
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithAuthProvider.html
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInAnonymously.html
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailLink.html
      // https://stackoverflow.com/questions/67617502/what-are-the-error-codes-for-flutter-firebase-auth-exception
      if (e.code == 'user-not-found') {
        res = 'kullanici bulunamadi';
      } else if (e.code == 'wrong-password') {
        res = 'yanlis sifre';
      } else if (e.code == 'user-disabled') {
        res = 'kullanici pasif';
      }
    }
    return res;
  }

  Future<String?> signUp(
      String email, String username, String fullname, String password) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        // ! Collection yapısı firebase firestore database içindeki collectin
        // ! add deyince map yapısı istiyor
        final resultData = await firebaseFirestore.collection("Users").add({
          "bio": "",
          "email": email,
          "followers": [],
          "following": [],
          "fullname": fullname,
          "post": [],
          "username": username,
        });
      } catch (e) {
        print("$e aaaaaaaaaaaa");
      }
      res = 'success';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          res = 'Mail zaten kayitli';
          break;
        case 'ERROR-INVALID-EMAIL':
        case 'invalid-email':
          res = 'Gecersiz email';
          break;
        default:
          res = 'bir hata ile karsilasildi';
          break;
      }
    }
    return res;
  }
}
