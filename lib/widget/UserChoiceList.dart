import 'package:commander/User.dart';
import 'package:commander/controllers/UserChoiceForGroupsController.dart';
import 'package:flutter/material.dart';

class UserChoiceList extends StatelessWidget {
  final UserChoiceForGroupController userChoiceController;
  final List<User> users;
  const UserChoiceList(
      {Key? key, required this.userChoiceController, required this.users})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) changeState) {
        return Container(
          height: 200,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              String userId = users[index].userKey;
              String userName = users[index].username;
              return CheckboxListTile(
                value: this.userChoiceController.containsId(userId),
                title: Text(
                  userName,
                  textDirection: TextDirection.rtl,
                ),
                activeColor: Colors.green,
                onChanged: (bool? value) {
                  if (value != null)
                    !value
                        ? this.userChoiceController.removeId(userId)
                        : this.userChoiceController.addId(userId);
                  changeState(() {});
                },
              );
            },
          ),
        );
      },
    );
  }
}
