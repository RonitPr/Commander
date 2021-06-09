import 'package:commander/widget/CommanderDialogUI.dart';
import 'package:commander/widget/CreateCommandForm2.dart';
import 'package:flutter/material.dart';

import 'User.dart';

class Group extends StatelessWidget {
  final String id;
  final String title;
  final List<User> users;
  final String author;
  final Function refreshFunction;

  const Group(
      {Key? key,
      required this.title,
      required this.users,
      required this.id,
      required this.author,
      required this.refreshFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              this.title,
              overflow: TextOverflow.fade,
            ),
          ),
          TextButton(
            onPressed: () async {
              await getDialog(
                context,
                "צור פקודה חדשה לקבוצה",
                CreateCommandForm2(
                  author: author,
                  refreshFunction: refreshFunction,
                  fromGroup: this.users,
                ),
              );
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.lightGreen[800],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('צור פקודה'),
            ),
          ),
        ],
      ),
      textColor: Colors.green[800],
      iconColor: Colors.green[800],
      children: this
          .users
          .map(
            (usr) => ListTile(
              title: Text(usr.username),
            ),
          )
          .toList(),
    );
  }
}
