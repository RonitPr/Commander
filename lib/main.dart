import 'package:commander/Group.dart';
import 'package:commander/screens/LoginScreen.dart';
import 'package:commander/screens/mainScreen.dart';
import 'package:commander/server/command.dart';
import 'package:commander/server/group.dart';
import 'package:commander/widget/CommanderDialogUI.dart';
import 'package:commander/widget/CreateCommandForm.dart';
import 'package:commander/widget/CreateGroupForm.dart';
import 'package:flutter/material.dart';

import 'Command.dart';
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
  List<Command> commands = [];
  List<Group> groups = <Group>[
    Group(
      id: "someRandomId",
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

  void onLogin(User user) {
    setState(() {
      this.currentUser = user;
    });
    refreshCommands();
  }

  void refreshCommands() async {
    List<Command>? commands = await getCommandsById('a');
    setState(() {
      this.commands = commands!;
    });
  }

  void refreshGroups() async {
    List<Group>? groups;
    groups = (await getGroups(currentUser!.userKey))!.cast<Group>();
    setState(() {
      this.groups = groups!;
    });
  }

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
                            onPressed: () async {
                              await getDialog(
                                  context,
                                  "צור קבוצה חדשה",
                                  CreateGroupForm(
                                    author: this.currentUser!.userKey,
                                    refreshFunction: refreshGroups,
                                  ));
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
      body: this.currentUser == null
          ? LoginScreen(onLogin)
          : MainScreen(
              commands: commands,
            ),
      floatingActionButton: this.currentUser == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                List<User> users = [
                  User('1שם של דביל', 'userKey1'),
                  User('2שם של דביל', 'userKey2'),
                  User('3שם של דביל', 'userKey3'),
                  User('4שם של דביל', 'userKey4'),
                  User('5שם של דביל', 'userKey5'),
                  User('6שם של דביל', 'userKey6'),
                  User('7שם של דביל', 'userKey7'),
                  User('8שם של דביל', 'userKey8'),
                  User('9שם של דביל', 'userKey9'),
                ];
                await getDialog(
                  context,
                  "צור פקודה חדשה",
                  CreateCommandForm(users),
                );
              },
              label: Text('צור פקודה חדשה'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.green[800],
            ),
    );
  }
}
