import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedium/create_patient.dart';
import 'package:remedium/nav_drawer.dart';
import 'package:remedium/patient_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;


class doctor_inventory extends StatefulWidget {
  @override
  _doctor_inventoryState createState() => _doctor_inventoryState();
}

class _doctor_inventoryState extends State<doctor_inventory> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: nav_drawer(),
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(80.0)),
                  onPressed: () {},
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Row(
                    children: [
                      Text("Search for Patient with name",
                          style: TextStyle(color: Colors.blueAccent)),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(80.0)),
                  onPressed: () {},
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                ),
              ],
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
                )
              ]),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 80.0),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => create_patient()),
          );
        },
        label: Text('Add Patient'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('patient').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<MessageBubble> messageBubbles = [];



        for (var message in messages) {
          final name = message.data['last_name'];
          final gender = message.data['gender'];
          final date = message.data['date'];
          final email = message.data['email'];
          String result = message.data['result'];
          if (result == null) result = "pending";
          final uid = message.data['doctor_uid'];

          final currentUser = loggedInUser.uid;

          if(currentUser == uid ){
            final messageBubble = MessageBubble(
              name: name,
              gender: gender,
              date: date,
              result: result,
              email: email,
            );

            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.email, this.name, this.gender, this.date, this.result});
  final String email;
  final String name;
  final String gender;
  final String date;
  final String result;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => patient_profile(
                    recieved_date: email,
                  )),
        );
      },
      child: Card(
        elevation: 15,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${name}"),
                  Text("Gender: ${gender}"),
                  Text("Test Date: ${date}"),
                  Text("COVID-19 Status: ${result}"),
                ],
              ),
            ),
            Column(
              children: [
                CircularProfileAvatar(
                  '',
                  child: FlutterLogo(),
                  borderColor: Colors.purpleAccent,
                  borderWidth: 5,
                  elevation: 2,
                  radius: 50,
                ),
                Text("id:")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
