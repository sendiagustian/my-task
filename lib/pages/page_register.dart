import 'package:crud/pages/page_task.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();

  final Firestore _database = Firestore.instance;
  String nama,username,password;

  void _registerAkun() {
    _database.runTransaction((Transaction transaction) async{
      CollectionReference reference= Firestore.instance.collection('users');
      await reference.add({
        "nama": nama,
        "username": username,
        "password": password,
      });
    });
    Navigator.pop(context);
  }
  
  @override
  void initState() { 
    super.initState();
    // _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/ic_launcher.png'),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  controller: controller1,
                  onChanged: (String str){
                    setState((){
                      nama = str;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: "Nama Lengkap",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  controller: controller2,
                  onChanged: (String str){
                    setState((){
                      username = str;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: "Username",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  controller: controller3,
                  onChanged: (String str){
                    setState((){
                      password = str;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  padding: EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.input,
                        color:Colors.white
                      ),
                      SizedBox(width: 10.0),
                      Text('Register',
                      style: TextStyle(
                        color: Colors.white,
                        // fontFamily:'Comfortaa',
                        ),
                      ),
                    ],
                  ),
                  onPressed: (){
                    _registerAkun();
                  },
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}