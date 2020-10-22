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
  print(response.body);

  twitter.close();
}
