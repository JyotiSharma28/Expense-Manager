import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forget_password extends StatefulWidget {
  const Forget_password({Key? key}) : super(key: key);

  @override
  State<Forget_password> createState() => _Forget_passwordState();
}

class _Forget_passwordState extends State<Forget_password> {

  final emailcontroller = TextEditingController();

  @override
  void dispose(){
    emailcontroller.dispose();
    super.dispose();
  }

  void passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim()).then((value) => Navigator.of(context).pop());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Password reset link sent! Check your email "),
        );
      });
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff368983),
        automaticallyImplyLeading: false,
        title: Text("Expense manager"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children:[
          Text(
             "Enter your Email and we will send you a password reset link",
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: 20),
          ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
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

              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed:(){ passwordReset();},
              child: Text('Reset Password',style: TextStyle(fontSize: 20),),
              color: Color(0xff368983),
              height: 40,
            )
          ] ,
    ),

    );
  }
}
