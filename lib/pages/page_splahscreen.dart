import 'package:crud/pages/references.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


PreferenceUtil appData = new PreferenceUtil();

class _SplashScreenState extends State<SplashScreen> {

  bool isLogin = false;

  @override
  void initState() { 
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      (){
        isLogin? Navigator.of(context).pushReplacementNamed("/catatanku") : Navigator.of(context).pushReplacementNamed("/login");
      }
    );
    appData.checkLogin().then((result) {
      if (result) {
        setState(() {
          isLogin = true;
        });
      }
    });
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
