import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Image.asset(
              'Assets/Logo.png',
              color: Colors.green,
              scale: 1.5,
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(bottom: 10),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.green.shade800, width: 1.0),
                ),
                hintText: 'שם משתמש',
              ),
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(bottom: 10),
            child: TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.green.shade800, width: 1.0),
                ),
                hintText: 'סיסמה',
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                // TODO :: create new group.
              },
              style: TextButton.styleFrom(
                primary: Colors.green[800],
                backgroundColor: Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('התחבר',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
