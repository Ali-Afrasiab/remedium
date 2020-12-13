import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedium/doctor_inventory.dart';

import 'doctor_sign_in.dart';
import 'package:intl/intl.dart';


final _firestore = Firestore.instance;

final DateTime now = DateTime. now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter. format(now);


class create_patient extends StatefulWidget {
  @override
  _create_patientState createState() => _create_patientState();

}

class _create_patientState extends State<create_patient> {
  File _image;
  final _auth = FirebaseAuth.instance;
  String email;
  String first_name;
  String last_name;
  String age;
  String gender;
  String zip_code;
  String telephone;
  String condition;


  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

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
                  const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text("Create Patient Profile!                      ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text(
                          " Fill out the form below so we can get you started.",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white70)),
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
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        "Personal Information                                        ",
                        style: TextStyle(fontSize: 20)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              first_name = value;
                            },
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "First Name",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              last_name = value;
                            },
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "Last Name",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              age = value;
                            },
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "Age",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButton(
                            onChanged: (value) {
                              value == 1 ? gender = "male" : gender = "female";
                            },
                            hint: Text("gender"),
                            value: 1,
                            items: [
                              DropdownMenuItem(
                                child: Text("Male"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Female"),
                                value: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Contact Info                                        ",
                        style: TextStyle(fontSize: 24)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "Email",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              zip_code = value;
                            },
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "Zip Code",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              telephone = value;
                            },
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "Telephone",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          onChanged: (value) {
                            condition = value;
                          },
                          obscureText: true,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,

                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Pre-Diagnosis Condition:",
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () async {
                    try {
                      ;
                      _firestore.collection('patient').add({
                        'first_name': first_name,
                        'email': email,
                        'last_name': last_name,
                        'age': age,
                        'gender': gender,
                        'zip_code': zip_code,
                        'telephone': telephone,
                        'condition': condition,
                        'date': formatted,
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => doctor_inventory()),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Submit", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
