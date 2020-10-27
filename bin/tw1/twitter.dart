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
  final response =
      await twitter.request('GET', 'favorites/list.json?include_entities=true');
//  final response = await twitter.request('GET', 'statuses/home_timeline.json');

  print(response.body);

  List<dynamic> jsonResponse = json.decode(response.body);
  for (var tw in jsonResponse) {
    final extendedEntities = tw['extended_entities'];
    if (extendedEntities != null) {
      final media = extendedEntities['media'] as List<dynamic>;
      if (media != null) {
        print('------------------------------------------------');
        print(tw['user']['name']);
        print(tw['text']);
        for (var me in media) {
          print(me['media_url_https']);
        }
      }
    }
  }

  twitter.close();
}
