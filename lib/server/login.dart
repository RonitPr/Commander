import 'dart:convert';

import 'package:commander/User.dart';
import 'package:http/http.dart' as http;

String server_url = 'https://commander-server.herokuapp.com';

Future<User?> login(String username, String password) async {
  Uri url =
      Uri.parse('$server_url/login?username=$username&password=$password');
  http.Response r = await http.get(url);
  if (r.statusCode != 200) {
    return null;
  }
  var userMap = jsonDecode(r.body);

  return User(userMap['username'], userMap['uid']);
}
