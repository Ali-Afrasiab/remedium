import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedium/doctor_inventory.dart';

import 'doctor_sign_in.dart';

final _firestore = Firestore.instance;

class patient_profile extends StatefulWidget {
  @override
  _patient_profileState createState() => _patient_profileState();
}

class _patient_profileState extends State<patient_profile> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var _value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 15.0, bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlatButton(
                   onPressed : (){Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => doctor_inventory()),
                   );},
                    child: Icon(
                      Icons.backspace_outlined,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Column(
                    children: [

                      Text("Patient Profile",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  ),
                ],
              )),
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
        preferredSize: new Size(MediaQuery.of(context).size.width, 50.0),
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
          final name =message.data['last_name'];
          final gender = message.data['gender'];
          final condition = message.data['condition'];
          //final date = message.data['date'];
          final telephone = message.data['telephone'];
          String result = message.data['result'];
          if(result==null) result="pending";
          final email = message.data['email'];


          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            name: name,
            gender: gender,
            //date: date,
            condition: condition,
            result: result,
            telephone: telephone,
              email: email,
          );

          messageBubbles.add(messageBubble);
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
  MessageBubble({this.email,this.name, this.gender,this.result,this.telephone,this.condition,this.age });

  String email;


  String name;
  String age;
  String gender;
  String result;
  String telephone;

  String condition;



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFC8EAF4),
            Color(0xFFD5EAD7),
            Color(0xFFFDFEFF),
          ],
        ),
      ),
      child: Column(


        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 10,),
                GestureDetector(
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Text("Name",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Age: ${age}", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),),
                    Text("Gender: ${gender}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),),

                  ],
                ),
                SizedBox(height: 50,),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Email: ${email}", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),),
                    Text("Telephone: ${telephone}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),),

                  ],
                ),
                SizedBox(height: 50
                  ,),
                Column(

                  children: [
                    Text("Pre-Diagnosis Condition: ${condition}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("",style:TextStyle(fontSize: 16),),
                        )
                    )
                  ],
                ),SizedBox(height: 50
                  ,),
                Column(


                  children: [
                    Text("Status: ${result}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),),
                  ],
                ),
              ],
            ),
          ),



          Container(

            child: Column(

              children: [
                RaisedButton(
                    onPressed: (){;},
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                    shape:  new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                    child: Text("Create Report",style:TextStyle(color: Colors.white))),
              ],
            ),
          ),],
      ),
    );
  }
}
