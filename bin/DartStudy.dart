import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(List<String> arguments) async {
  print(await _fetchUsers());
}

class User {
  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.createdAt,
  });
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        email = json['email'] as String,
        createdAt = DateTime.parse(json["createdAt"] as String);
}

Future<List<User>> _fetchUsers() async {
  final response =
  await http.get('http://www.mocky.io/v2/5c55243c2f00005000bf758a');
  final stopwatch = Stopwatch()..start();
  final users = _parse(response.body);
  stopwatch.stop();
  print('elapsed: ${stopwatch.elapsedMilliseconds}');
  return users;
}

List<User> _parse(String body) {
  final json = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
  return json.map((j) => User.fromJson(j)).toList();
}