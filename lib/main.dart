import 'package:crud/pages/page_login.dart';
import 'package:crud/pages/page_register.dart';
import 'package:crud/pages/page_splahscreen.dart';
import 'package:crud/pages/page_task.dart';
import 'package:flutter/material.dart';

void main(){
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Task",
      home: SplashScreen(),
      routes: <String, WidgetBuilder> { 
        '/mytask' : (BuildContext context) => MyTask(),
        '/login' : (BuildContext context) => LoginPage(),
        '/register' : (BuildContext context) => RegisterPage(),
      }
    );
  }
}
