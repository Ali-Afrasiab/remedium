

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remedium/doctor_sign_in.dart';

import 'main.dart';

class nav_drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(decoration: new BoxDecoration(
                color: Color(0xFF202125),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.blue,
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  ),
                ]),
              child: DrawerHeader(
                child: Text(
                  'Remedium',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFF202125),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/cover.jpg'))),
              ),
            ),
            /*ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () => {Navigator.of(context).pop()},
            ),*/
            ListTile(
              tileColor: Colors.blueGrey,
              leading: Icon(Icons.exit_to_app,color: Colors.white),
              title: Text('Logout',style: TextStyle(color: Colors.white),),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
            Column(
              children: [

              Container(
                width: 500,
                height: 1000,

                decoration: new BoxDecoration(
                    color: Color(0xFF202125),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.blue,
                        blurRadius: 20.0,
                        spreadRadius: 1.0,
                      ),
                    ]),



              )
            ],)
          ],
        ),
      ),
    );
  }

}


