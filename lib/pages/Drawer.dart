import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/Screens/home.dart';
import 'package:expense_manager/Screens/statistics.dart';
import 'package:expense_manager/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/pages/Drawer/Setting/setting.dart';
import 'package:expense_manager/pages/controller/datacontroller.dart';
import 'package:expense_manager/pages/services/auth_services.dart';
import 'package:share_plus/share_plus.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final DataController controller = Get.find();

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

  Future<String?> fetchUsernameForCurrentUser() async {
    // Check if the user is authenticated
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the 'users' collection in Firestore
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query to find the user with the specified user_id (assuming 'user_id' is a field in your documents)
      QuerySnapshot querySnapshot = await usersCollection
          .where('user_id', isEqualTo: user.uid)
          .limit(1)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        var userDocument = querySnapshot.docs.first;

        // Extract the 'username' field from the document
        var username = userDocument['username'];
         print(username);
        // Return the username
        return username;

      } else {
        // No user found with the specified user_id
        return null;
      }
    } else {
      // User is not authenticated
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Future<String?> username =  fetchUsernameForCurrentUser() ;

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
             // 'User : ${username}',
                'User : Jyoti',
            ),
            accountEmail: Text(
              'Email : ${AuthService.getProfileEmail()}',
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "J",
                style: TextStyle(fontSize: 40.0, color: Colors.blue),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_sharp),
            title: Text("Accounts"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_chart),
            title: Text("Charts"),
            onTap: () {
              Get.to(()=>Statistics());
            },
          ),

          ListTile(
            leading: Icon(Icons.payment_sharp),
            title: Text("Regular payments"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.remember_me_sharp),
            title: Text("Reminders"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Setting_Page()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.highlight_off),
            title: Text("Turn off ads"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share_sharp),
            title: Text("Share with friends"),
            onTap: () {
              Share.share("");
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log out"),
            onTap: () {
                _signOut();
            },
          ),
        ],
      ),
    );
  }
}
