import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedium/consultation.dart';
import 'package:remedium/covid.dart';
import 'package:remedium/doctor_inventory.dart';
import 'package:remedium/report_generate.dart';
import 'package:remedium/test.dart';

import 'doctor_sign_in.dart';

final _firestore = Firestore.instance;


class doctor_profile extends StatefulWidget {
  final pass_email;
  doctor_profile({this.pass_email});

  @override
  _doctor_profileState createState() => _doctor_profileState(recieved_email: pass_email);
}

class _doctor_profileState extends State<doctor_profile> {
  final _auth = FirebaseAuth.instance;
  _doctor_profileState({this.recieved_email});
  final String recieved_email;



  @override
  Widget build(BuildContext context) {
    var _value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new PreferredSize(
        child: new Container(
          //padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding:  EdgeInsets.all(20),
          child: Row(

            children: [
              IconButton(

                  icon: Icon(Icons.arrow_back,color: CupertinoColors.white,),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>consultation()),
                    );
                  }),
              Text("Doctor Profile",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
          decoration: new BoxDecoration(

              color: Color(0xFF202125),

              boxShadow: [
                new BoxShadow(
                  color: Colors.blue,
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                ),
              ]
          ),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 50.0),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            MessagesStream(recieved: recieved_email),

          ],
        ),
      ),

    );
  }
}

class MessagesStream extends StatelessWidget {
  MessagesStream({this.recieved});


  final String recieved;

  String email;
  String first_name;
  String last_name;
  String gender;
  String condition;
  String telephone;
  String result;
  String age;
  String date;
  Color colour;
  String description;
  String experience;
  String degree;


  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('doctor').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        // List<MessageBubble> messageBubbles = [];
        print(recieved);
        for (var message in messages) {

          if(message.data['email']== recieved)
          {  email = message.data['email'];
          first_name =message.data['first_name'];
          last_name =message.data['last_name'];
          gender = message.data['gender'];
          description = message.data['description'];
          experience = message.data['experience'];
          telephone = message.data['telephone'];
          age = message.data['age'];
          degree = message.data['degree'];





          }
        }

        return Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202125),
              ),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Card(


                          color: Color(0XFF3E3F43),
                          elevation: 10,
                          //shadowColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Row(

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: GestureDetector(
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 10, 10, 20),
                                child: Card(

                                  color: Color(0XFF3E3F43),
                                  // elevation: 50,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Name : ",style:TextStyle(color: Colors.white70),),
                                          Text("${first_name} ${last_name}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Gender : ",style:TextStyle(color: Colors.white70),),
                                          Text("${gender}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Age : ",style:TextStyle(color: Colors.white70),),
                                          Text("${age}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),

                                    ],
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Card(

                            color: Color(0XFF3E3F43),
                            elevation: 10,

                            //shadowColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Email : ",style:TextStyle(color: Colors.white70),),
                                          Text("${email}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),
                                      Row
                                        (
                                        children: [
                                          Text("Phone : ",style:TextStyle(color: Colors.white70),),
                                          Text("${telephone}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),

                        Column(

                          children: [
                            Text("Description: ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: CupertinoColors.white),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Card(

                            color: Color(0XFF3E3F43),
                            elevation: 10,

                            //shadowColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("${description}",style:TextStyle(fontSize: 18,color: CupertinoColors.white)),
                            ),

                          ),
                        ),
                        SizedBox(height: 30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("STATUS: ",style:TextStyle(fontSize: 20,color: CupertinoColors.white) ),
                                Text("awaiting",style:TextStyle(fontSize: 20,color: colour) ),
                              ],
                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                  FloatingActionButton.extended(
                    backgroundColor:Color(0XFF3C4043),
                    focusColor: Colors.blue,
                    focusElevation: 100,
                    splashColor: CupertinoColors.white,
                    onPressed: ()async{
                      try{

                        _firestore.collection('consultation').add({
                          'first_name': first_name,
                          'email': email,
                          'last_name': last_name,
                          'age': age,
                          'gender': gender,
                          'degree': degree,
                          'telephone': telephone,
                          'request': "awaiting",
                          'experience': experience,
                          'description' : description,
                        });



                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => doctor_inventory()),
                          );}
                      catch(e){print(e);}
                    },
                    label: Text('Send Request'),
                    icon: Icon(Icons.add),

                  ),],
              ),
            )
        );
      },
    );
  }


}



