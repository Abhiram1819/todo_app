import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/add_task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => addtask()));
          showModalBottomSheet<void>(
            // context and builder are
            // required properties in this widget
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              // we set up a container inside which
              // we create center column and display text
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: Container(
                  padding:EdgeInsets.only(top:10,right: 30,left:30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text('Add New Task',style: TextStyle(
  	                    fontWeight: FontWeight.bold, fontSize: 28, color: Colors.blue),),
                      ),SizedBox(height: 30,),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Task'),
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Task',
                            style: GoogleFonts.roboto(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
