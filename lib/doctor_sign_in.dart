import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'doctor_inventory.dart';
import 'doctor_sign_up.dart';
import 'main.dart';


class doctor_sign_in extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
            child: Center(
              child: new Text(
                'Remedium',
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: [
                Color(0xFF3DC9EE),
                Color(0xFF78CFD9),
                Color(0xFFBCE4E6),
              ]),
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey[500],
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                ),
              ]),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 80.0),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFC8EAF4),
              Color(0xFFD5EAD7),
              Color(0xFFFDFEFF),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Doctor", style: TextStyle(fontSize: 25))),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              RaisedButton(
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () async {

                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => doctor_inventory()),
                    );
                    */
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      final FirebaseUser user = await _auth.currentUser();
                      final uid = user.uid;

                      if (newUser != null)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => doctor_inventory()),
                        );
                    } catch (e) {
                      print(e);

                    }
                  },
                  child: Text("Login", style: TextStyle(color: Colors.white))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: null,
                    child: Text("forgot_password"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => doctor_sign_up()),
                      );
                    },
                    child: Text("Sign up"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
