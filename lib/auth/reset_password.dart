import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class resetpassword extends StatefulWidget {
  const resetpassword({Key? key}) : super(key: key);

  @override
  _resetpasswordState createState() => _resetpasswordState();
}

class _resetpasswordState extends State<resetpassword> {
  var _email = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Container(
        child: Column(
          children: [
            TextField(
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
            TextButton(
                onPressed: () {
                  resetpassword();
                },
                child: Text("Reset Password"))
          ],
        ),
      ),
    );
  }

  void resetpassword() {
    if (_email.length == 0 || !_email.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid Email");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      Navigator.of(context).pop();
    }
  }
}
