import 'package:expense_manager/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/pages/Enter_main_account_bal.dart';
import 'package:get/get.dart';
import 'controller/datacontroller.dart';


class Welcome_page extends StatelessWidget {
  const Welcome_page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final DataController controller=Get.put(DataController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color(0xff368983),
        automaticallyImplyLeading: false,
        title: Text("Expense manager"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
            child: Column(
              children: [
               Image.asset('images/logo.png'),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        "Welcome to Money Manager!",
                        style: TextStyle(fontSize:24,fontWeight: FontWeight.bold,color: Color(0xff368983)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 11),
                        child: Text(
                          "Expense manager- an app to track income and expense with ease.",
                          style: TextStyle(fontSize:20,color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: (){
                          Get.to(()=>Bottom());
                        },
                        child: new Container(
                          height: 50.0,
                          width: 170.0,
                          decoration: new BoxDecoration(
                            color: Color(0xff368983),
                            border: new Border.all(color: Colors.white, width: 2.0),
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: new Center(child: new Text('Next', style: new TextStyle(fontSize: 20.0, color: Colors.white),),),
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
    );
  }
}
