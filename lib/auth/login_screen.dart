import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/auth/reset_password.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/auth/reg_screen.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  var _email, _password;
  var _formkey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signin'),
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
                          hintText: "Enter valid Email",
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
                        return item!.length > 6 ? null : "Enter valid Password";
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
                          login();
                        },
                        child: Text(
                          "Login",
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
                                      builder: (_) => registration()));
                            },
                            child: Text(
                              "Register here",
                              style: TextStyle(color: Colors.red),
                            )),
                        alignment: Alignment.centerRight),
                    Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => resetpassword()));
                            },
                            child: Text("Forgot Password?")),
                        alignment: Alignment.bottomCenter)
                  ],
                ),
              ),
            ),
    );
  }

  void login() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Login Success");
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
