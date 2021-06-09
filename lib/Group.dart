import 'package:commander/widget/CommanderDialogUI.dart';
import 'package:commander/widget/CreateCommandForm.dart';
import 'package:flutter/material.dart';

import 'User.dart';

class Group extends StatelessWidget {
  final String id;
  final String title;
  final List<User> users;

  const Group(
      {Key? key, required this.title, required this.users, required this.id})
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
                CreateCommandForm(users),
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
