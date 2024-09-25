import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:voicify/data/cache/cache_helper.dart';
import 'package:voicify/firebase/firebase.dart';
import 'package:voicify/models/user/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  late UserModel user;

  void saveUser(userCredential) {
    SharedHelper.saveData(FirebaseKeys.userId, userCredential.user!.uid);
  }

  Future<void> signIn() async {
    emit(LoadingSignIn());
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      await getUserFireStore(userCredential.user!.uid);
      saveUser(userCredential);
      emit(SuccessSignIn());
    } on FirebaseAuthException catch (e) {
      print('*********$e.code');

      if (e.code == 'invalid-email') {
        print('Firebase Authentication Exception: ${e.code}/////////////');
      } else if (e.code == 'user-not-found') {
        print('Firebase Authentication Exception: ${e.code}/////////////');
      } else if (e.code == 'wrong-password') {
        print('Firebase Authentication Exception: ${e.code}/////////////');
      } else {
        print("**************************${getMessageFromErrorCode(e)}");
      }
      emit(FailedSignIn(err: "Wrong Email Or Password"));
      print("**************************${getMessageFromErrorCode(e)}");
    } catch (e) {
      emit(FailedSignIn(err: 'Wrong Email Or Password'));
      print('Firebase Authentication Exception: $e/////////////');
    }
    print(state);
  }

  void clear() {
    email.clear();
    name.clear();
    password.clear();
    emit(Cleared());
  }

  Future<void> signUp() async {
    emit(LoadingSignUp());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      await addUserFireStore(userCredential.user!.uid, false);
      saveUser(userCredential);
      emit(SuccessSignUp());
    } on Exception catch (e) {
      if (e is PlatformException) {
        if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
          emit(EmailUsed());
        }
        emit(FailedSignUp(err: e.code));
      }
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    emit(LoadingSignOut());
    try {
      auth.signOut();
      SharedHelper.remove(FirebaseKeys.userId);
      emit(SuccessSignOut());
    } on FirebaseException catch (e) {
      emit(FailedSignOut(err: e.toString()));
      print(e.toString());
    }
  }

  Future<User?> signInWithGoogle() async {
    print("Loading");
    emit(LoadingSignUpWithGoogle());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("تم إلغاء تسجيل الدخول بواسطة المستخدم");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("SuccessSignUpWithGoogle");
      await checkIfUserFound(userCredential);

      saveUser(userCredential);
      emit(SuccessSignUpWithGoogle());
      print("SuccessSignUpWithGoogle");
      return userCredential.user;
    } catch (e) {
      emit(FailedSignUpWithGoogle(err: e.toString()));
      print("خطأ في تسجيل الدخول باستخدام Google: ${e.toString()}");
      return null;
    }
  }

  Future<void> checkIfUserFound(UserCredential userCredential) async {
    DocumentSnapshot user = await fireStore
        .collection(FirebaseKeys.users)
        .doc(userCredential.user!.uid)
        .get();
    if (user.exists) {
      getUserFireStore(userCredential.user!.uid);
    } else {
      await addUserFireStore(
        userCredential.user!.uid,
        true,
        googleEmail: userCredential.user!.email ?? '',
        googleName: userCredential.user!.displayName ?? '',
      );
    }
    getUserFireStore(userCredential.user!.uid);
  }

  Future<void> addUserFireStore(String userId, bool google,
      {String googleName = '', String googleEmail = ''}) async {
    emit(LoadingAddUserFireStore());
    try {
      await fireStore.collection(FirebaseKeys.users).doc(userId).set({
        FirebaseKeys.name: google ? googleName : name.text,
        FirebaseKeys.email: google ? googleEmail : email.text,
      });
      user = UserModel(
          name: google ? googleName : name.text,
          email: google ? googleEmail : email.text,
          password: password.text);
      emit(SuccessAddUserFireStore());
    } on FirebaseException catch (e) {
      emit(FailedAddUserFireStore(err: e.toString()));
      print(e.toString());
    }
  }

  Future<void> getUserFireStore(String userId) async {
    emit(LoadingGetUserFireStore());
    try {
      DocumentSnapshot data =
          await fireStore.collection(FirebaseKeys.users).doc(userId).get();
      user = UserModel(
          name: data['name'], email: data['email'], password: 'password');
      emit(SuccessGetUserFireStore());
    } on Exception catch (e) {
      emit(FailedGetUserFireStore(err: e.toString()));
      print("${e.toString()}");
    }
  }

  Future<void> resetPassword(email) async {
    emit(LoadingSendLink());
    try {
      await auth.sendPasswordResetEmail(email: email);
      emit(SuccessSendLink());
    } on Exception catch (e) {
      emit(FailedSendLink(err: e.toString()));
      print("************${e.toString()}");
    }
  }

// Future<void> loginWithFacebook() async {
//   final result = await facebookLogin.logIn(['email']);
//   switch (result.status) {
//     case FacebookLoginStatus.loggedIn:
//       // You're logged in with Facebook, use result.accessToken to make API calls.
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       // User cancelled the login.
//       break;
//     case FacebookLoginStatus.error:
//       // There was an error during login.
//       break;
//   }
// }
}

String getMessageFromErrorCode(err) {
  switch (err) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
      break;
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
      break;
    default:
      return "Login failed. Please try again.";
      break;
  }
}
