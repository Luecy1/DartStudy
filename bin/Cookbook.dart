import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(int id) async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/$id');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album id = $id');
  }
}

Future<Album> deleteAlbum(String id) async {
  final response = await http.delete(
    'https://jsonplaceholder.typicode.com/albums/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to delete album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  String toString() {
    return 'Album{id: $id, title: $title}';
  }
}

void main() async {
  for (var i = 1; i < 10; i++) {
    final album = await fetchAlbum(i);
    print(album);
  }
}
