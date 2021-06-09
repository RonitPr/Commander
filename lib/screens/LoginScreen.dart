import 'package:commander/server/login.dart';
import 'package:flutter/material.dart';
import '../User.dart';

class LoginScreen extends StatefulWidget {
  final Function(User) callback;
  LoginScreen(this.callback);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage;
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
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
                  controller: usernameController,
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
                  controller: passwordController,
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
              this.errorMessage == null
                  ? Container()
                  : Text(
                      errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              Container(
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    User? a = await login(
                        usernameController.text, passwordController.text);
                    setState(() {
                      isLoading = false;
                    });
                    if (a != null) {
                      widget.callback(a);
                    } else {
                      setState(() {
                        errorMessage =
                            'אופס ! נראה שאתה לא יכול להתחבר כרגע...';
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.green[800],
                    backgroundColor: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'התחבר',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        this.isLoading
            ? Container(
                color: Colors.green[900],
                child: Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
