import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/add_task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController task = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
        centerTitle: true,
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
        onPressed: () {
          showModalBottomSheet<void>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.85,
                child: Container(
                  padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          child: Center(
                              child: Text(
                            "New Task",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ) // Your desired title
                              ),
                        ),
                        Container(
                            margin: EdgeInsets.all(0),
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                color: Colors.red, // Your desired icon
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }))
                      ]),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: TextField(
                          controller: task,
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
                          controller: desc,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Description'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 100,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Add',
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
