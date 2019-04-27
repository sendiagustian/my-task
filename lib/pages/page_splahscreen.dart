import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() { 
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      (){
        Navigator.of(context).pushReplacementNamed("/mytask");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 200, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            image: AssetImage('images/logo.png')
          )
        ),
      ),
    );
  }
}
