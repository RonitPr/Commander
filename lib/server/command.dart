import 'dart:convert';
import 'package:commander/Command.dart';
import 'package:commander/util/UtilFunctions.dart';
import 'package:http/http.dart' as http;

String server_url = 'https://commander-server.herokuapp.com';

Future<String?> createCommand(String title, String author,
    List<String> requires, List<String> watchers) async {
  String requiredStrings = getStringFromList(requires);
  String watchersStrings = getStringFromList(watchers);
  Uri uri = Uri.parse(
      '$server_url/addCommand?title=$title&author=$author&required_list=$requiredStrings&watch_list=$watchersStrings');
  http.Response r = await http.get(uri);
  if (r.statusCode != 200) {
    return "ERROR";
  } else {
    return "OK";
  }
}

Future<List<Command>?> getCommandsById(String uid) async {
  Uri uri = Uri.parse('$server_url/getMyCommands?uid=$uid');
  http.Response r = await http.get(uri);
  if (r.statusCode != 200) {
    print('objectooooooo');
    return [];
  }
  var data = jsonDecode(r.body);
  List<Command> commands = [];
  for (var command in data) {
    String author = command['author'];
    String cid = command['cid'];
    String title = command['title'];
    List require = command['required_list'] as List<dynamic>;
    List watchers = command['watch_list'] as List<dynamic>;
    List accepted = command['approved_list'] as List<dynamic>;
    commands.add(Command(author, title, cid, require, accepted, watchers));
  }
  return commands;
}

Future<bool> approveCommand(String uid, String cid) async {
  Uri uri = Uri.parse('$server_url/approveCommand?uid=$uid&cid=$cid');
  http.Response r = await http.get(uri);
  if (r.statusCode != 200) {
    return false;
  }
  return true;
}
