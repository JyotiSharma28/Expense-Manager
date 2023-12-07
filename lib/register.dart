import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/login.dart';
import 'package:expense_manager/pages/controller/auth_controller.dart';
import 'package:get/get.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  final firestore=FirebaseFirestore.instance;

  Map<String, String> userSignUpData = {
    "username": "",
    "email": "",
    "password": ""
  };

  AuthController controller=Get.find();

  signUp() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      _formKey.currentState!.save();
      print('$userSignUpData');
      controller.signUp(userSignUpData['username']!,userSignUpData['email']!,userSignUpData['password']!);

    }
  }

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return 'E-mail address is required.';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail))
      return 'Invalid E-mail Address format.';

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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
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
                              controller: namecontroller,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name field is required ";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userSignUpData['username'] = value!;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailcontroller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: validateEmail,
                              onSaved: (value) {
                                userSignUpData['email'] = value!;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passwordcontroller,
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  validator: validatePassword,
                              onSaved: (value) {
                                userSignUpData['password'] = value!;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                       onPressed: (){
                                         signUp();
                                       // Get.to(()=>MyLogin());
                                       },
                                      //      () {
                                      //   if (_formKey.currentState!.validate()) {

                                      //         email: emailcontroller.text.toString(),
                                      //         password: passwordcontroller.text.toString()
                                      //     ).then((value){
                                      //                 FirebaseFirestore.instance.collection('user').doc(value.user?.uid).set({"email":value.user?.email,"password":value.user?.uid});
                                      //     }).onError((error, stackTrace){
                                      //       utils().toastMessage(error.toString());
                                      //     });  //     _auth.createUserWithEmailAndPassword(
                                      //     if (namecontroller.text.isNotEmpty &&
                                      //         emailcontroller.text.isNotEmpty &&
                                      //         passwordcontroller.text.isNotEmpty){
                                      //       firestore.collection("user").add({
                                      //         "Name": namecontroller.text,
                                      //         "Email": emailcontroller.text,
                                      //         "Password": passwordcontroller.text,
                                      //       });
                                      //     }
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(builder: (context) => const MyLogin()),
                                      //     );
                                      //   };
                                      //
                                      //
                                      // },

                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
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
                                    Get.to(()=>MyLogin());
                                  },
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
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
