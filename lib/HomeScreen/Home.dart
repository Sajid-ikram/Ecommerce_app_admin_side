import 'package:ecommerce_app_for_admin/LogIn/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Home"),
          ),
          OutlinedButton(
              onPressed: () {
                Provider.of<Authentication>(context, listen: false).signOut();
              },
              child: Text("out")),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("addNewProduct");
              },
              child: Text("Add new product"))
        ],
      ),
    );
  }
}
