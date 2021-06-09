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
    return null;
  }
  var data = jsonDecode(r.body);
  List<Command> commands = [];
  for (var command in data) {
    String cid = command['cid'];
    String title = command['title'];
    List required = command['required_list'] as List<dynamic>;
    List watchers = command['watch_list'] as List<dynamic>;
    List accepted = command['approved_list'] as List<dynamic>;
    commands.add(Command(title, cid, required, accepted, watchers));
  }
  return commands;
}
