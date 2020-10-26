import 'dart:convert';

import 'package:twitter/twitter.dart';

import 'key.dart';

void main() async {
  final twitter = Twitter(
    API_KEY,
    API_KEY_SECRET,
    ACCESS_TOKEN,
    ACCESS_TOKEN_SECRET,
  );
  final response = await twitter.request('GET', 'favorites/list.json');
//  final response = await twitter.request('GET', 'statuses/home_timeline.json');

  List<dynamic> jsonResponce = json.decode(response.body);
  for (var tw in jsonResponce) {
    print(tw['user']['name']);
    print(tw['text']);
  }

  twitter.close();
}
