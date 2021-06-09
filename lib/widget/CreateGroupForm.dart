import 'package:commander/controllers/UserChoiceForGroupsController.dart';
import 'package:commander/widget/UserChoiceList.dart';
import 'package:flutter/material.dart';

class CreateGroupForm extends StatefulWidget {
  const CreateGroupForm({Key? key}) : super(key: key);

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
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // Send data to server.
                  //print(groupNameController.text);
                  //print(this.userChoiceController.getSelectedUserIds());
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('יצירת קבוצה הושלמה בהצלחה')));
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
