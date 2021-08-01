import 'package:amazing_quotes/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const routes = "category_screen";
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text(
          "Quoted by Category",
          style: TextStyle(color: Colors.white, fontSize: 23, letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              getListTile(
                name: "AB",
                title: "Ability",
                color: Colors.green.shade300,
                context: context,
                type: "ATTITUDE",
              ),
              getDivider(),
              getListTile(
                name: "AC",
                title: "Accuracy",
                color: Colors.amber.shade300,
                context: context,
                type: "LOVE",
              ),
              getDivider(),
              getListTile(
                name: "AD",
                title: "Advice",
                color: Colors.pink.shade300,
                context: context,
                type: "ATTITUDE",
              ),
              getDivider(),
              getListTile(
                name: "AG",
                title: "Age",
                color: Colors.red.shade300,
                context: context,
                type: "LOVE",
              ),
              getDivider(),
              getListTile(
                name: "AL",
                title: "Alcohol",
                color: Colors.teal.shade300,
                context: context,
                type: "ATTITUDE",
              ),
              getDivider(),
              getListTile(
                name: "AM",
                title: "Ambition",
                color: Colors.purple.shade300,
                context: context,
                type: "LOVE",
              ),
              getDivider(),
              getListTile(
                name: "AF",
                title: "American Football",
                color: Colors.redAccent,
                context: context,
                type: "ATTITUDE",
              ),
              getDivider(),
              getListTile(
                name: "AP",
                title: "Apology",
                color: Colors.blue.shade300,
                context: context,
                type: "LOVE",
              ),
              getDivider(),
              getListTile(
                name: "AN",
                title: "Animals",
                color: Colors.deepOrange.shade300,
                context: context,
                type: "ATTITUDE",
              ),
              getDivider(),
              getListTile(
                name: "AR",
                title: "Art",
                color: Colors.brown.shade300,
                context: context,
                type: "LOVE",
              ),
              getDivider(),
              getListTile(
                name: "AT",
                title: "Attitude",
                color: Colors.green.shade300,
                context: context,
                type: "ATTITUDE",
              ),
              getDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
