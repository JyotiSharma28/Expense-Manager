import 'package:flutter/material.dart';

class AppbarPage extends StatefulWidget {
  const AppbarPage({Key? key}) : super(key: key);

  @override
  State<AppbarPage> createState() => _AppbarPageState();
}

class _AppbarPageState extends State<AppbarPage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title: Text('Expense manager',style: TextStyle(fontSize: 25)),
      title: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(Icons.paid_sharp),
              Text("Total",),
            ],

          ),
          Text("1030")

        ],
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      bottom: const TabBar(
        tabs: [
          Tab(child: Text(
            "EXPENSES",style: TextStyle(fontSize: 18),
          ),
          ),
          Tab(child: Text(
            "INCOME",style: TextStyle(fontSize: 18),
          ),)
        ],
      ),
    );
  }
}
