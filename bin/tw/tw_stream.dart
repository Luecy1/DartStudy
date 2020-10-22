import 'dart:convert';

import 'package:http/http.dart' as http;

import 'key.dart';

void main() async {
  final url = Uri.parse('https://api.twitter.com/2/tweets/sample/stream');

  final request = http.Request('GET', url);
  request.headers['Authorization'] = 'Bearer ${BEARER}';

  final client = http.Client();

  var streamedResponse = await client.send(request);

  final steam =
      streamedResponse.stream.map((event) => Utf8Decoder().convert(event));

  steam.listen((event) {
    print(event);
  });

  // infinite loop
  while (true) {
    await Future.delayed(Duration(minutes: 1));
  }
}
