import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class EditTask extends StatefulWidget {

  EditTask({this.index, this.title, this.duedate, this.note});
  final String title;
  final String note;
  final DateTime duedate;
  final index;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  TextEditingController controllerTitle;
  TextEditingController controllerNote;

  DateTime _dueDate;
  String _dateText = '';

  String newTask;
  String note;


  void _updateTask(){
    Firestore.instance.runTransaction((Transaction transaction) async{
      DocumentSnapshot snapshot =
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "title": newTask,
        "note": note,
        "duedate": _dueDate
      });
      Navigator.pop(context);
    });
  }
  

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


  @override
  void initState() {
    super.initState();
    _dueDate = widget.duedate;
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    newTask = widget.title;
    note = widget.note;

    controllerTitle = TextEditingController(text: widget.title);
    controllerNote = TextEditingController(text: widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Catatan"),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controllerTitle,
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
                maxLines: 3,
                controller: controllerNote,
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
                padding:EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      color: Colors.indigo,
                      icon: Icon(Icons.check, size: 40),
                      onPressed: (){
                        _updateTask();
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
