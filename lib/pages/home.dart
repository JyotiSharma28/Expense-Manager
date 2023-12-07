// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:untitled1/pages/Drawer.dart';
// import 'package:untitled1/pages/controller/datacontroller.dart';
// import 'package:untitled1/pages/home/expenses.dart';
// import 'package:untitled1/pages/home/income.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> with TickerProviderStateMixin {
//
//   final DataController controller=Get.put(DataController());
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     CollectionReference users = FirebaseFirestore.instance.collection('userlist').where('user_id',isEqualTo: );
//     late final _tabController = TabController(length: 2, vsync: this);
//
//     return DefaultTabController(
//       initialIndex: 1,  //optional, starts from 0, select the tab by default
//       length:2,
//       child: Scaffold(
//         appBar: AppBar(
//          // title: Text('Expense manager',style: TextStyle(fontSize: 25)),
//           title: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.paid_sharp),
//                   Text("Total",),
//                 ],
//               ),
//           FutureBuilder<DocumentSnapshot>(
//             future: users.doc('1ePB19YKNmZBUQuX9dYM').get(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//
//               if (snapshot.hasError) {
//                 return Text("Something went wrong");
//               }
//
//               if (snapshot.hasData && !snapshot.data!.exists) {
//                 return Text("Document does not exist");
//               }
//
//               if (snapshot.connectionState == ConnectionState.done) {
//                 Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//                 return Text(" ${data['balance']}");
//               }
//               return Text("loading");
//             },
//           )
//             ],
//           ),
//           centerTitle: true,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20)
//           ),
//           bottom: const TabBar(
//             tabs: [
//               Tab(child: Text(
//                 "EXPENSES",style: TextStyle(fontSize: 18),
//               ),
//               ),
//               Tab(child: Text(
//                 "INCOME",style: TextStyle(fontSize: 18),
//               ),)
//             ],
//           ),
//         ),
//         drawer: DrawerPage(),
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             Expense_page(
//               onNext: ()=>_tabController.index=1,
//             ),
//             Income_page(
//               onNext: ()=>_tabController.index=2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/pages/Drawer.dart';
import 'package:expense_manager/pages/controller/auth_controller.dart';
import 'package:expense_manager/pages/controller/datacontroller.dart';
//import 'package:expense_manager/pages/expenses.dart';
//import 'package:expense_manager/pages/income.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// class _HomeState extends State<Home> with TickerProviderStateMixin {
//   final DataController controller = Get.put(DataController());
//   late final _tabController = TabController(length: 2, vsync: this);
//   late DocumentReference<Map<String, dynamic>>? user;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Call the function to fetch data
//   }
//
//   // Function to fetch user data from Firebase
//   Future<void> fetchData() async {
//     var querySnapshot = await FirebaseFirestore.instance
//         .collection('userlist')
//         .where('user_id', isEqualTo: AuthController().auth.currentUser?.uid)
//         .get();
//     if (querySnapshot.docs.isNotEmpty) {
//       var document = querySnapshot.docs.first;
//       print(document);
//       user = FirebaseFirestore.instance.collection('userlist').doc(document.id);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: 1,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.paid_sharp),
//                   Text("Total"),
//                 ],
//               ),
//               // Display user data once it's fetched
//               FutureBuilder<DocumentSnapshot>(
//                 future: user?.get(),
//                 builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Text("Loading");
//                   } else if (snapshot.hasError) {
//                     return Text("Something went wrong");
//                   } else if (snapshot.hasData && snapshot.data!.exists) {
//                     Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//                     return Text(" ${data['balance']}");
//                   }
//                   return Text("loading");
//                 },
//               )
//             ],
//           ),
//           centerTitle: true,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 child: Text(
//                   "EXPENSES",
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//               Tab(
//                 child: Text(
//                   "INCOME",
//                   style: TextStyle(fontSize: 18),
//                 ),
//               )
//             ],
//           ),
//         ),
//         drawer: DrawerPage(),
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             Expense_page(
//               onNext: () => _tabController.index = 1,
//             ),
//             Income_page(
//               onNext: () => _tabController.index = 2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class _HomeState extends State<Home> with TickerProviderStateMixin {
  final DataController controller = Get.put(DataController());
      late final _tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            // appBar: AppBar(title: Text('Loading User Data')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text("Something went wrong")),
          );
        } else if (snapshot.hasData && snapshot.data!.exists) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Total"),
                      ],
                    ),
                    Text("₹${data['balance']}",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),), // Replace 'your_data_field' with the actual field you want to display
                  ],
                ),
                centerTitle: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        "EXPENSES",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "INCOME",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              drawer: DrawerPage(),
              body: TabBarView(
                controller: _tabController,
                children: [
                  // Expense_page(onNext: () => _tabController.index = 1),
                  // Income_page(onNext: () => _tabController.index = 2),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: Text('User Not Found')),
            body: Center(child: Text("No user data found")),
          );
        }
      },
    );
  }

  // Function to fetch user data from Firebase
  Future<DocumentSnapshot> fetchUserData() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('userlist')
        .where('user_id', isEqualTo: AuthController().auth.currentUser?.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;
      return FirebaseFirestore.instance.collection('userlist').doc(document.id).get();
    }

    return Future.value(null); // Return a completed Future with null if no user data found
  }
}