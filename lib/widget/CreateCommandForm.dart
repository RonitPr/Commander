import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../User.dart';

class CreateCommandForm extends StatefulWidget {
  final List<User> users;
  const CreateCommandForm(
    this.users, {
    Key? key,
  }) : super(key: key);

  @override
  _CreateCommandFormState createState() => _CreateCommandFormState();
}

class _CreateCommandFormState extends State<CreateCommandForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  String fileName = '';
  var fileBytes;
  List<String> requires = [];
  List<String> watchs = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: title,
                validator: (valide) {
                  if (valide == null || valide.isEmpty) {
                    return 'הכנס כותרת פקודה';
                  }
                  return null;
                },
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  labelText: 'הכנס כותרת פקודה',
                  labelStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.green, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            fileBytes == null
                ? ElevatedButton(
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
                    child: Text('בחר קובץ'),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
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
            SizedBox(
              height: 25,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Text('שם משתמש'),
                  ),
                  Text('מאשר'),
                  Text('צופה'),
                ],
              ),
            ),
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              clipBehavior: Clip.antiAlias,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.builder(
                  itemCount: widget.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool require = false;
                    bool watch = false;
                    return StatefulBuilder(
                      builder: (context, setState) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Text(widget.users[index].username),
                          ),
                          Checkbox(
                            value: require,
                            onChanged: (flag) {
                              require = flag!;
                              if (flag) {
                                requires.add(widget.users[index].userKey);
                                watchs.remove(widget.users[index].userKey);
                                watch = false;
                              } else
                                requires.remove(widget.users[index].userKey);
                              setState(() {});
                            },
                          ),
                          Checkbox(
                            value: watch,
                            onChanged: (flag) {
                              watch = flag!;
                              if (flag) {
                                watchs.add(widget.users[index].userKey);
                                requires.remove(widget.users[index].userKey);
                                require = false;
                              } else
                                watchs.remove(widget.users[index].userKey);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 250,
            ),
            ElevatedButton(
              onPressed: () {
                pushToDB(title.text, requires, watchs);
                Navigator.of(context).pop();
              },
              child: Text('צור פקודה'),
            ),
          ],
        ),
      ),
    );
  }

  void pushToDB(String s, List list2, List list3) {
    print(s);
    print(list2.toString());
    print(list3.toString());
  }
}
