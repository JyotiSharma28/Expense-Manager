import 'package:expense_manager/pages/forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/pages/controller/auth_controller.dart';
import 'package:expense_manager/register.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  Map<String, String> userLoginData = {"email": "", "password": ""};
  AuthController controller = Get.put(AuthController());

  login() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      _formKey.currentState!.save();
      controller.login(userLoginData['email']!, userLoginData['password']!);
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> loginUsingEmailPassword(
      {required String email,
        required String password,
        required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("no user found for that email");
      }
    }
    return user;
  }

  String errorMessage = '';

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return 'E-mail address is required.';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty)
      return 'Password is required.';

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword))
      return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: validateEmail,
                              onSaved: (value) {
                                userLoginData['email'] = value!;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(),
                              controller: passwordcontroller,
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: validatePassword,
                              onSaved: (value) {
                                userLoginData['password'] = value!;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Text(errorMessage),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    ),
                                    onPressed:(){
                                      login();
                                    },
                                    //     ()async {
                                    //
                                    //   if (_formKey.currentState!.validate()){
                                    //     User? user=await loginUsingEmailPassword(email: emailcontroller.text, password: passwordcontroller.text, context: context);
                                    //     print(user);
                                    //     if(user != null){
                                    //       // Navigator.of(conpushReplacement(MaterialPageRoute(builder: (context)=> Welcome_page()));
                                    //       Navigator.pushReplacementNamed(context,'/welcome_page');
                                    //     }
                                    //
                                    //   }
                                    // },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const MyRegister()),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: () {
                                    Get.to(Forget_password());
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),

                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
