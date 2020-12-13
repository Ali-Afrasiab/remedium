import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'dart:io';
import 'package:flutter/material.dart';
class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      /*onPressed: (){Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => patient_profile()),
      );}*//*,*/
      child: Card(

        elevation: 15,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(

          children: [
            Padding(
              padding: const EdgeInsets.all(55.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name "),
                  Text("Gender"),
                  Text("Test Date: "),
                  Text("COVID-19 Status :"),
                  Text("Pre-Diagnosed Conditions:"),
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

class StatelessWidget {
}
