import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addtask extends StatefulWidget {
  const addtask({Key? key}) : super(key: key);

  @override
  _addtaskState createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Enter Task'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Description'),
                ),
              ),SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Add Task',style: GoogleFonts.roboto(fontSize:18),
                ),
              ),
              )
            ],
          )),
    );
  }
}
