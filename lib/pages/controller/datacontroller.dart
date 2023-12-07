import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:expense_manager/pages/controller/auth_controller.dart';

class DataController extends GetxController {
  AuthController authcontroller = AuthController();
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {'userName': '', 'Email': '', 'balance': ''};
  static String username = "";

  void onReady() {
    super.onReady();
    getUserProfileData();
    // getbalance();
  }

  Future<void> getUserProfileData() async {
    String username = "";
    print("user_id : user_id  ${username}");
    try {
     // FirebaseFirestore.instance
     //      .collection('userlist')
     //      .doc('UWtsjbwFtFXuYA0gxxZN')
     //      .get()
     //      .then((value) {
     //    username = value.data()?['email'];
     //    print("value from firebase");
     //    print(value);
     //  });

      var querySnapshot = await FirebaseFirestore.instance
          .collection('userlist')
          .where('user_id', isEqualTo: AuthController().auth.currentUser?.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;
        var user =  FirebaseFirestore.instance.collection('userlist').doc(document.id);
        //uesrname = user.get().;
        print("hgyhfhf");
        print(user);
      }
      // var response = await firebaseInstance
      //     .collection('userlist')
      //     .where('user_id',isEqualTo:authcontroller.user_Id)
      //     .get();
      // //   response.docs.forEach((result) {
      // //   print(result.data());
      // // });
      // if (response.docs.length > 0) {
      //   userProfileData['userName'] = response.docs[0]['username'];
      //   userProfileData['Email'] = response.docs[0]['email'];
      // }
      // print(userProfileData);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  Future<void> getbalance() async {
    try {
      var response = await firebaseInstance
          .collection('userlist')
          .where('user_id', isEqualTo: authcontroller.user_Id)
          .get();

      if (response.docs.length > 0) {
        userProfileData['balance'] = response.docs[0]['balance'];
      }
      print(userProfileData);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
