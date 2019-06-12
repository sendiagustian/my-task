import 'package:crud/pages/page_detail.dart';
import 'package:crud/pages/page_addTask.dart';
import 'package:crud/pages/page_editTask.dart';
import 'package:crud/pages/references.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyTask extends StatefulWidget {

  final nama,username,password,dataId;
  MyTask({this.nama, this.username, this.password, this.dataId});

  @override
  _MyTaskState createState() => _MyTaskState();
}

List dataTask;
PreferenceUtil appData = new PreferenceUtil();

class _MyTaskState extends State<MyTask> {

  void _deleteTask(final index){
    Firestore.instance.runTransaction((Transaction transaction) async{
      DocumentSnapshot snapshot =
      await transaction.get(index);
      await transaction.delete(snapshot.reference);
    });
  }

  void _showModalAlert(String title, String content, final index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                _deleteTask(index);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Widget MyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            onTap: (){
              appData.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            title: Text(
              'Logout'
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catatan Ku"),
        backgroundColor: Colors.indigo,
      ),
      drawer: MyDrawer(),
      body: StreamBuilder(
        stream: Firestore.instance.collection('task')
        .where('user_id', isEqualTo: widget.dataId)
        .orderBy('tanggal', descending: true)
        .orderBy('waktu', descending: true)
        .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('Loading...');
          return ListView(
              children: snapshot.data.documents.map((document) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => DetailTask(
                        task: document['title'],
                        note: document['note'],
                        date: document['duedate'].day.toString() +"/"+ document['duedate'].month.toString()+"/" + document['duedate'].year.toString()
                      )
                    ));
                  },
                  child: ListTile(
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Tanggal:',
                            style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)
                          ),
                          Text(
                            document['duedate'].day.toString() +"/"+ document['duedate'].month.toString()+"/" + document['duedate'].year.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            document['title'] ?? '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          Text(
                            document['note'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: <Widget>[
                          InkWell(
                            child: Icon(Icons.edit, size: 20,),
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => EditTask(
                                    index: document.reference,
                                    title: document['title'],
                                    note: document['note'],
                                    duedate: document['duedate']
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          InkWell(
                            child: Icon(Icons.delete, size: 20),
                            onTap: (){
                              _showModalAlert(
                                'Peringatan',
                                'Apakah task ini akan di hapus?',
                                document.reference
                              );
                            },
                          ),
                        ],
                      )
                    ),
                ),
                Divider(color: Colors.grey[800], indent:0.0,),
              ],
            );
          }).toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => AddTask(dataId: widget.dataId,)));
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        color: Colors.indigo,
        child: ButtonBar(
          children: <Widget>[],
        ),
      ),
    );
  }
}