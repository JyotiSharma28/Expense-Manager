import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/login.dart';
import 'package:expense_manager/pages/Drawer.dart';
import 'package:expense_manager/pages/Enter_main_account_bal.dart';
import 'package:expense_manager/pages/Welcome_page.dart';
import 'package:expense_manager/pages/controller/auth_controller.dart';
import 'package:expense_manager/pages/home.dart';
import 'package:expense_manager/register.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_manager/widgets/bottomnavigationbar.dart';
import 'data/model/add_date.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<AuthService>(
//           create:(_)=>AuthService(FirebaseAuth.instance) ,
//         ),
//         StreamProvider(
//           create: (context)=>context.read(), initialData: null,
//         ),
//       ],
//      child: MaterialApp(
//        title: "App",
//        home: AuthWrapper(),
//      ),
//     );
//   }
// }
//
//
// class AuthWrapper extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//      return MyRegister();
//
//   }
// }

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization=Firebase.initializeApp();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("could not connected"),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return Center(
              child: user != null ? Bottom() : MyLogin(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },

      ),
      routes: {
        '/register': (context) => MyRegister(),
        '/login': (context) => MyLogin(),
        '/account_bal_enter': (context) => Account_bal_enter(),
        '/welcome_page': (context) => Welcome_page(),
        '/drawer': (context) => DrawerPage(),
        '/home': (context) => Home(),
      },
    );
  }
}