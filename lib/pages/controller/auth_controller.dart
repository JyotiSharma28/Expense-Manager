import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/pages/controller/commom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_manager/login.dart';
import 'package:expense_manager/pages/Enter_main_account_bal.dart';
import 'package:expense_manager/pages/controller/commom_dialog.dart';
import 'package:expense_manager/pages/home.dart';
import '../../utils/utils.dart';
import '../Welcome_page.dart';

class AuthController extends GetxController{

  final firestore=FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var user_Id;

  Future<void>signUp(  username,email,  password)async{
    try {
      CommanDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password
      );
      print(userCredential);
      CommanDialog.hideLoading();

      try{
         CommanDialog.showLoading();
         var response=await FirebaseFirestore.instance.collection('userlist').add({
           'user_id':userCredential.user!.uid,
           'username':username,
           'email':email,
           'password':password,
           'joinDate':DateTime.now().millisecondsSinceEpoch
          }
         );
         //print("Firebase response ${response.id}");
         CommanDialog.hideLoading();
         Get.back();
      } catch(exception){
             CommanDialog.hideLoading();
             print("Error Saving data at firestore $exception");
      }

      Get.back();
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'weak-password') {
        CommanDialog.showErrorDialog(description:"the password provide is too weak");
      } else if (e.code == 'email-already-in-use') {
        CommanDialog.showErrorDialog(description:"The account already exists for that email.");
      }
    } catch (e) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog(description:"Something went wrong");
      print(e);
    }
  }

  Future<void>login( email, password)async{
    print('$email,$password');
    try {
      CommanDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password
      );
      print(userCredential.user!.uid);
      user_Id=userCredential.user!.uid;

      CommanDialog.hideLoading();
      Get.off(()=>Welcome_page());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CommanDialog.showErrorDialog(description: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        CommanDialog.showErrorDialog(description: "Wrong password provided for that user.");
      }
    }
  }

  Future<void>balance(balance)async{
    print(balance);
    Future<void> inputData() async {
      final User? user = auth.currentUser;
      final uid = user?.uid;
      print(uid);
      if(uid != null){
        // var document = await FirebaseFirestore.instance.doc('userlist/UWtsjbwFtFXuYA0gxxZN');
        var querySnapshot = await FirebaseFirestore.instance.collection('userlist')
            .where('user_id', isEqualTo: auth.currentUser?.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var document = querySnapshot.docs.first;
          var documentReference = FirebaseFirestore.instance.collection('userlist').doc(document.id);

          // Update the "balance" field in the found document
          await documentReference.update({
            'balance': balance,
          });

          print('Balance updated...');
        } else {
          print('No document found with the specified email.');
        }
      // document.set({'balance':balance},SetOptions(merge: true));
      //   document.get().then((document) {
      // print(document.data());// }
      // );
      }
    }
    try{
      CommanDialog.showLoading();
      inputData();
      CommanDialog.hideLoading();
      Get.to(()=>Home());
    } catch(exception){
      CommanDialog.hideLoading();
      print("Error Saving data at firestore $exception");
    }
  }


  // User Information Section

  // static getProfileName() {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   if (auth.currentUser?.displayName != null) {
  //     return auth.currentUser?.displayName;
  //   } else {
  //     return "Username is not present !";
  //   }
  // }

  // static getProfileEmail() {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   if (auth.currentUser?.email != null) {
  //     return auth.currentUser?.email;
  //   } else {
  //     return "Email Address Error !";
  //   }
  // }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Clear any cached data or state, e.g., using GetX controllers.
      // Example: YourDataController().clearData();

      // Navigate to the login page.
      Get.offAll(() => MyLogin());
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}