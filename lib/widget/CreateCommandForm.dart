import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../User.dart';

class CreateCommandForm extends StatefulWidget {
  const CreateCommandForm({Key? key}) : super(key: key);

  @override
  _CreateCommandFormState createState() => _CreateCommandFormState();
}

class _CreateCommandFormState extends State<CreateCommandForm> {
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
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text('שם משתמש'),
                  SizedBox(
                    width: 20,
                  ),
                  Text('מאשר'),
                  SizedBox(
                    width: 20,
                  ),
                  Text('צופה'),
                  SizedBox(
                    width: 20,
                  ),
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
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool require = false;
                    bool watch = false;
                    return StatefulBuilder(
                      builder: (context, setState) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(users[index].username),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            // requires
                            child: Checkbox(
                              value: require,
                              onChanged: (flag) {
                                require = flag!;
                                if (flag) {
                                  requires.add(users[index].userKey);
                                  watchs.remove(users[index].userKey);
                                  watch = false;
                                } else
                                  requires.remove(users[index].userKey);
                                setState(() {});
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            // watchers
                            child: Checkbox(
                              value: watch,
                              onChanged: (flag) {
                                watch = flag!;
                                if (flag) {
                                  watchs.add(users[index].userKey);
                                  requires.remove(users[index].userKey);
                                  require = false;
                                } else
                                  watchs.remove(users[index].userKey);
                                setState(() {});
                              },
                            ),
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
