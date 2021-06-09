import 'package:commander/controllers/UserChoiceForGroupsController.dart';
import 'package:flutter/material.dart';

class UserChoiceList extends StatelessWidget {
  final UserChoiceForGroupController userChoiceController;
  const UserChoiceList({Key? key, required this.userChoiceController})
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
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              String userId = "12345" + index.toString();
              String userName = "שם של דביל" + index.toString();
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
