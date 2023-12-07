import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/login.dart';
import 'package:expense_manager/pages/controller/auth_controller.dart';
import 'package:get/get.dart';

class Setting_Page extends StatefulWidget {
  const Setting_Page({Key? key}) : super(key: key);

  @override
  State<Setting_Page> createState() => _Setting_PageState();
}

class _Setting_PageState extends State<Setting_Page> {
  String selectedMode = 'Default';
  var isDarkTheme =true;
  final AuthController authController = Get.find<AuthController>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        centerTitle:true,
     ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("Pin",style: TextStyle(fontSize: 20),) ,
              leading: Icon(
                Icons.lock,
                size: 30,
                color: Colors.black54,
              ),
            ),
          ),
          Card(
            child: ListTile(

              title: Text("Language",style: TextStyle(fontSize: 20),) ,
              subtitle: Text("English"),
              leading: Icon(
                Icons.language,
                size: 30,
              ),
            ),
          ),
          Card(
            child: ListTile(

              title: Text("Default Period",style: TextStyle(fontSize: 20),) ,
              subtitle: Text("Week"),
              leading: Icon(
                Icons.calendar_month,
                size: 30,
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Select theme",style: TextStyle(fontSize: 20),) ,
              subtitle: Text("Default"),
              leading: Icon(
                Icons.dark_mode,
                size: 30,
              ),
              // trailing: Switch(
              //   value: isDarkTheme, // Replace with your theme control variable
              //   onChanged: (value) {
              //     // Toggle the theme when the switch is changed
              //     setState(() {
              //       isDarkTheme = value; // Update the theme control variable
              //       // Call a function to change the theme based on the value
              //     });
              //   },
              // ),
            ),

          ),
          Card(
            child: ListTile(
              title: Text("Delete all the data",style: TextStyle(fontSize: 20),) ,
              leading: Icon(
                Icons.delete,
                size: 30,
              ),
              onTap: (){
                _signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
