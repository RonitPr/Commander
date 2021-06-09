import 'package:commander/controllers/UserChoiceForGroupsController.dart';
import 'package:commander/server/group.dart';
import 'package:commander/widget/UserChoiceList.dart';
import 'package:flutter/material.dart';

class CreateGroupForm extends StatefulWidget {
  final String author;
  const CreateGroupForm({Key? key, required this.author}) : super(key: key);

  @override
  _CreateGroupFormState createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  final _formKey = GlobalKey<FormState>();
  UserChoiceForGroupController userChoiceController =
      UserChoiceForGroupController();
  TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          TextFormField(
            controller: groupNameController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'מרגיש כאילו משהו חסר';
              }
              return null;
            },
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: "הכנס שם לקבוצה",
              labelStyle: TextStyle(color: Colors.green),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 1.0),
              ),
            ),
          ),
          Spacer(flex: 1),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text("?את מי תרצה להוסיף לקבוצה"),
          ),
          UserChoiceList(
            userChoiceController: this.userChoiceController,
          ),
          Spacer(flex: 2),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // Send data to server.
                  var response = await createNewGroup(
                    widget.author,
                    this.userChoiceController.getSelectedUserIds(),
                    groupNameController.text,
                  );
                  if (response == "OK")
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('יצירת קבוצה הושלמה בהצלחה')));
                  else
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('אופס.. נראה שהייתה בעיה ביצירה')));
                }
              },
              child: Icon(Icons.done, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
