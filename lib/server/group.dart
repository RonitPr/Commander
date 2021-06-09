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

Future<List<Group?>?> getGroups(String uid) async {
  Uri url = Uri.parse('$server_url/getUserGroups?uid=' + uid);
  http.Response r = await http.get(url);
  if (r.statusCode != 200) {
    return null;
  }
  List<dynamic> groupsMap = jsonDecode(r.body);
  List<Group> groups = [];
  groupsMap.forEach((groupObject) {
    groups.add(Group(
      id: groupObject["gid"],
      title: groupObject["title"],
      users: createUserList(groupObject["uid_list"] as List<String>),
    ));
  });

  return groups;
}

List<User> createUserList(List<String> uidList) {
  List<User> users = [];
  uidList.forEach((uid) async {
    User? user = await getUserById(uid);
    users.add(user!);
  });
  return users;
}
