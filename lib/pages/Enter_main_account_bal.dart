import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/pages/controller/datacontroller.dart';
import 'package:expense_manager/pages/home.dart';

import 'controller/auth_controller.dart';

class Account_bal_enter extends StatefulWidget {
  const Account_bal_enter({Key? key}) : super(key: key);

  @override
  State<Account_bal_enter> createState() => _Account_bal_enterState();
}

class _Account_bal_enterState extends State<Account_bal_enter> {

  final balancecontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DataController controller1=Get.put(DataController());
  Map<String, String> balancedata = {
    "balance": "",
  };

  AuthController controller=Get.find();

  balance() {
    print("jsdjfjd");
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      _formKey.currentState!.save();
      controller.balance(balancedata['balance']!);
      Get.to(()=>Home());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense manager "),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                 Text(
                    "Enter main account balance",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize:25),
                  ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(left:20, right: 20, top:10),
                  child: Text(
                    "You can add more accounts in the Accounts section",
                      style: TextStyle(fontSize:17,color: Colors.black54),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.only(left:20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                            controller: balancecontroller,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                                labelText: "balance",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3
                                    )
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your balance ';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              balancedata['balance'] = value!;
                            },
                          ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right:65,top: 30),
                            child: Text('INR',style: TextStyle(fontSize: 35),textAlign: TextAlign.center,)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: (){
                          // if (_formKey.currentState!.validate()) {
                          //
                          //   CollectionReference collRef=FirebaseFirestore.instance.collection('balance');
                          //
                          //   collRef.add({
                          //     'balance':balancecontroller.text
                          //   });
                          //
                          //   Navigator.push(
                          //           context,
                          //           MaterialPageRoute(builder: (context) => const Home()),
                          //         );
                          //     };
                          balance();
                        },
                        child: new Container(
                          height: 50.0,
                          width: 170.0,
                          decoration: new BoxDecoration(
                            color: Colors.blueAccent,
                            border: new Border.all(color: Colors.white, width: 2.0),
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: new Center(child: new Text('Next', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
