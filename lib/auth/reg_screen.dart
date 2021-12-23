import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/auth/login_screen.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);

  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  var _email, _password;
  var _formkey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (item) {
                        return item!.contains("@") ? null : "Enter valid Email";
                      },
                      onChanged: (item) {
                        setState(() {
                          _email = item;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      validator: (item) {
                        return item!.length > 6
                            ? null
                            : "Password must be atleast 6 characters";
                      },
                      onChanged: (item) {
                        setState(() {
                          _password = item;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          signup();
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => loginscreen()));
                            },
                            child: Text(
                              "Login here",
                              style: TextStyle(color: Colors.red),
                            )),
                        alignment: Alignment.centerRight)
                  ],
                ),
              ),
            ),
    );
  }

  void signup() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Registration Success");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Home()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error" + onError.toString());
      });
    }
  }
}
