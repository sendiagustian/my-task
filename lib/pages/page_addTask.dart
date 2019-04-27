import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _dueDate = DateTime.now();
  String _dateText = '';

  String newTask = '';
  String note = '';

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2080),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _addData() {
    Firestore.instance.runTransaction((Transaction transaction) async{
      CollectionReference reference= Firestore.instance.collection('task');
      await reference.add({
        "title" : newTask,
        "duedate" : _dueDate,
        "note" : note
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Task"),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (String str){
                  setState(() {
                   newTask = str; 
                  });
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.widgets),
                    hintText: "New Task",
                    border: InputBorder.none),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.date_range),
                  Padding(padding: EdgeInsets.only(right: 16)),
                  Expanded(
                    child: Text(
                      "Due Date",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectDueDate(context),
                    child: Text(
                      _dateText,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: (String str){
                  setState((){
                    note = str;
                  });
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.note),
                    hintText: "Note",
                    border: InputBorder.none),
              ),
              Padding(
                padding:EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      color: Colors.indigo,
                      icon: Icon(Icons.check, size: 40),
                      onPressed: (){
                        _addData();
                      },
                      ),
                    IconButton(
                      color: Colors.indigo,
                      icon: Icon(Icons.close, size: 40),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
