import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/auth/reg_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TextEditingController _titleEditingController = TextEditingController();
  // TextEditingController _descEditingController = TextEditingController();
  String title = " ";
  String description = " ";

  createtask() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Tasks").doc(title);
    Map<String, String> todolist = {
      "todotitle": title,
      "tododesc": description
    };
    documentReference
        .set(todolist)
        .whenComplete(() => print("Task added successfully"));
  }

  deleteTodo(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Tasks").doc(item);

    documentReference
        .delete()
        .whenComplete(() => print("Task added successfully"));
    // SnackBar(content: Text("Task Deleted"),)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((onValue) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => registration()));
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Tasks").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        color: Colors.red[100],
                        elevation: 4,
                        child: ListTile(
                          title: Text((documentSnapshot != null)
                              ? (documentSnapshot["todotitle"])
                              : ""),
                          subtitle: Text((documentSnapshot != null)
                              ? (documentSnapshot["tododesc"])
                              : ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              Fluttertoast.showToast(
                                msg: "Task Deleted Successfully",
                                backgroundColor: Colors.grey,
                              );
                              setState(() {
                                deleteTodo((documentSnapshot != null)
                                    ? (documentSnapshot["todotitle"])
                                    : "");
                              });
                            },
                          ),
                        ),
                      ));
                });
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red,
              ),
            ),
          );
        },
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
                          )),
                        ),
                        Container(
                            margin: EdgeInsets.all(0),
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }))
                      ]),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: TextField(
                          onChanged: (String value) {
                            title = value;
                          },
                          // controller: _titleEditingController,
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
                          // controller: _descEditingController,
                          onChanged: (String value) {
                            description = value;
                          },
                          minLines: 1,
                          maxLines: 10,
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
                          onPressed: () {
                            setState(() {
                              createtask();
                            });
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                                msg: "Task Added Successfully",
                                backgroundColor: Colors.grey,
                              );
                          },
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
