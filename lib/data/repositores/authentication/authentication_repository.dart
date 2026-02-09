import 'package:admin_pannel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:admin_pannel/utils/exceptions/format_exceptions.dart';
import 'package:admin_pannel/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

// Firebase auth instance

  final _auth = FirebaseAuth.instance;

  //  GET AUTH USER DATA

  User? get authUser => _auth.currentUser;

  // Get isAuth User

  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    // rediorect to appropriate screen
    _auth.setPersistence(Persistence.LOCAL);
  }

  // FUNCTION TO DETERMINE THE REVELANT SCREEN AND REDIRECT ACCORDING TO IT

  // function to determine the revelant screen and redirect according to it
  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    // if the user is logged in
    if (user != null) {
      Get.offAllNamed(TRoutes.dashboard);
    } else {
      Get.offAllNamed(TRoutes.login);
    }
  }

  // LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  // lOGOUT
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  // REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("🔥 FIREBASE AUTH ERROR => code: ${e.code}, message: ${e.message}");
      rethrow;
    } catch (e) {
      print("🔥 UNKNOWN ERROR: $e");
      rethrow;
    }
  }
}
