import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//login
  Future loginUserAccount(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//signUp
  Future createUserAccount(String fullname, String phone, String email,
      String password, String adKey) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        //call our database service to update the user data
        await DatabaseService(uid: user.uid)
            .savingUserData(fullname, email, phone, adKey);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//signout
  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUserNameSF("");
      await HelperFunction.saveUserPhoneSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
