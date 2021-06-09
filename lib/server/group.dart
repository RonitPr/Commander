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
