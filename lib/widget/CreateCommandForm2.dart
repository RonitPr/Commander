import 'package:flutter/material.dart';
import 'package:commander/User.dart';
import 'package:commander/server/user.dart';
import 'package:commander/server/command.dart';
import 'package:file_picker/file_picker.dart';

class CreateCommandForm2 extends StatefulWidget {
  final String author;
  final Function refreshFunction;
  final List<User> fromGroup;
  const CreateCommandForm2({
    Key? key,
    required this.author,
    required this.refreshFunction,
    this.fromGroup = const [],
  }) : super(key: key);

  @override
  _CreateCommandForm2State createState() => _CreateCommandForm2State();
}

class _CreateCommandForm2State extends State<CreateCommandForm2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  List<String> requires = [];
  List<String> watchs = [];
  List<User> users = [];
  String fileName = '';
  var fileBytes;

  @override
  void initState() {
    super.initState();
    if (widget.fromGroup.isNotEmpty) {
      this.users = widget.fromGroup;
    } else {
      getAllUsers().then((value) {
        setState(() {
          this.users = value!;
        });
      });
    }
  }

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
            controller: titleController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'מרגיש כאילו משהו חסר';
              }
              return null;
            },
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: "כותרת הפקודה",
              labelStyle: TextStyle(color: Colors.green),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 1.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: fileBytes == null
                  ? ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        //https://github.com/miguelpruivo/flutter_file_picker/wiki/FAQ
                        if (result != null) {
                          fileName = result.files.first.name;
                          fileBytes = result.files.first.bytes;
                          setState(() {});
                        }
                      },
                      child: Text('הוסף קובץ פקודה'),
                    )
                  : Center(
                      child: Row(
                        children: [
                          Text(fileName),
                          IconButton(
                            onPressed: () {
                              fileName = '';
                              fileBytes = null;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          Spacer(flex: 1),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text("?למי תרצה לשלוח את הפקודה"),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                String userId = users[index].userKey;
                String userName = users[index].username;
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        userName,
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Container(
                        child: Row(
                          children: [
                            Container(width: 10),
                            Text("לאישור"),
                            Checkbox(
                              activeColor: Colors.green,
                              value: this.requires.contains(userId),
                              onChanged: (bool? value) {
                                if (value != null) {
                                  if (!value) {
                                    this.requires.remove(userId);
                                  } else {
                                    this.requires.add(userId);
                                  }
                                }
                                setState(() {});
                              },
                            ),
                            Text("להכרה"),
                            Checkbox(
                              activeColor: Colors.green,
                              value: this.watchs.contains(userId),
                              onChanged: (bool? value) {
                                if (value != null)
                                  !value
                                      ? this.watchs.remove(userId)
                                      : this.watchs.add(userId);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Spacer(flex: 2),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    (this.requires.isNotEmpty || this.watchs.isNotEmpty)) {
                  var responsePost = await createCommand(
                    titleController.text,
                    widget.author,
                    this.requires,
                    this.watchs,
                  );
                  widget.refreshFunction();
                  Navigator.pop(context);
                  if (responsePost == "OK")
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('יצירת פקודה הושלמה בהצלחה')));
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
