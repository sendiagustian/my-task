import 'package:flutter/material.dart';

class DetailTask extends StatefulWidget {
  final task, note, date;
  DetailTask({this.task, this.note, this.date});

  @override
  _DetailTaskState createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Catatan'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10),
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        widget.task,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(
                      widget.note,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        child: Text(
          'Due Date: ' + widget.date,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
