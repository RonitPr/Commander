import 'package:commander/Group.dart';
import 'package:commander/screens/LoginScreen.dart';
import 'package:commander/screens/mainScreen.dart';
import 'package:commander/server/command.dart';
import 'package:commander/server/group.dart';
import 'package:commander/widget/CommanderDialogUI.dart';
import 'package:commander/widget/CreateCommandForm2.dart';
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
  List<Group> groups = <Group>[];

  void onLogin(User user) {
    setState(() {
      this.currentUser = user;
    });

    refreshGroups();
    refreshCommands();
  }

  void refreshCommands() async {
    List<Command>? commands;
    commands = (await getCommandsById(currentUser!.userKey));
    setState(() {
      this.commands = commands!;
    });
  }

  void refreshGroups() async {
    List<Group>? groups;
    groups = (await getGroups(currentUser!.userKey, refreshCommands,
            currentUser!.userKey, currentUser!.username))!
        .cast<Group>();
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    this.currentUser = null;
                                    this.groups = [];
                                    this.commands = [];
                                  });
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('התנתק',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent,
                                      )),
                                ),
                              ),
                              TextButton(
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
                            ],
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
              user: currentUser!,
              commands: commands,
            ),
      floatingActionButton: this.currentUser == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                await getDialog(
                  context,
                  "צור פקודה חדשה",
                  CreateCommandForm2(
                    author: this.currentUser!.userKey,
                    authorName: this.currentUser!.username,
                    refreshFunction: refreshCommands,
                  ),
                );
              },
              label: Text('צור פקודה חדשה'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.green[800],
            ),
    );
  }
}
