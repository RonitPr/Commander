import 'package:commander/Group.dart';
import 'package:commander/screens/LoginScreen.dart';
import 'package:commander/screens/mainScreen.dart';
import 'package:commander/widget/CommanderDialog.dart';
import 'package:flutter/material.dart';

import 'User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'קומנדר',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? currentUser;
  List<Group> groups = <Group>[
    Group(
      title: 'קבוצה א׳',
      users: [
        User('איש 1', 'aaa'),
        User('איש 2', 'aaa'),
        User('איש 3', 'aaa'),
        User('איש 4', 'aaa'),
        User('איש 5', 'aaa'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Container(
          child: Row(
            children: [
              Image(
                image: AssetImage('Assets/logo.png'),
                height: 60,
              ),
            ],
          ),
        ),
      ),
      endDrawer: this.currentUser == null
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[800],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          'הקבוצות שלי',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              // TODO :: create new group.
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('צור קבוצה חדשה',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightGreen[800],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: this.groups,
                  ),
                ],
              ),
            ),
      body: this.currentUser == null ? LoginScreen() : MainScreen(),
      floatingActionButton: this.currentUser == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                await getDialog(context, "צור דוגמה", Container());
              },
              label: Text('צור פקודה חדשה'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.green[800],
            ),
    );
  }
}
