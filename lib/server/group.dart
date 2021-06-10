import 'dart:convert';

import 'package:commander/Group.dart';
import 'package:commander/User.dart';
import 'package:commander/server/user.dart';
import 'package:commander/util/UtilFunctions.dart';
import 'package:http/http.dart' as http;

String server_url = 'https://commander-server.herokuapp.com';

Future<String?> createNewGroup(
    String author, List<String> uid_list, String groupName) async {
  String uidListString = getStringFromList(uid_list);
  Uri url = Uri.parse(
      '$server_url/addGroup?author=$author&title=$groupName&uid_list=' +
          uidListString);
  http.Response r = await http.get(url);
  if (r.statusCode != 200) {
    return "ERROR";
  } else {
    return "OK";
  }
}

Future<List<Group?>?> getGroups(
    String uid, Function refreshForCommand, String authorForCommand, String authorForCommandNAME) async {
  Uri url = Uri.parse('$server_url/getUserGroups?uid=' + uid);
  http.Response r = await http.get(url);
  if (r.statusCode != 200) {
    return null;
  }
  List<dynamic> groupsMap = jsonDecode(r.body);
  List<Group> groups = [];
  await Future.forEach(groupsMap, (groupObject) async {
    if (groupObject != null) {
      Map<dynamic, dynamic> a = Map.from(groupObject as Map<dynamic, dynamic>);
      List<User> users = await createUserList(a["uid_list"]);
      groups.add(Group(
        id: groupObject["gid"],
        title: groupObject["title"],
        users: users,
        author: authorForCommand,
        authorName: authorForCommandNAME,
        refreshFunction: refreshForCommand,
      ));
    }
  });
  return groups;
}

Future<List<User>> createUserList(List<dynamic> uidList) async {
  List<User> users = [];
  await Future.forEach(uidList, (uid) {
    getUserById(uid as String).then((user) {
      users.add(user!);
    });
  });
  return users;
}
