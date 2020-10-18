import 'dart:convert';

import 'package:http/http.dart' as http;

import 'key.dart';

void main() async {
  final base64encoded =
      base64.encode(latin1.encode('${API_KEY}:${API_KEY_SECRET}'));

  final response = await http.post(
    'https://api.twitter.com/oauth2/token',
    headers: {'Authorization': 'Basic $base64encoded'},
    body: {'grant_type': 'client_credentials'},
  );

  print(response.body);

  final oauthToken = OauthToken.fromJson(jsonDecode(response.body));

  final result = await http.get(
    'https://api.twitter.com/2/users/by/username/Luecy1',
    headers: {'Authorization': 'Bearer ${oauthToken.accessToken}'},
  );

  print(result.body);
}

class OauthToken {
  final String tokenType;
  final String accessToken;

  OauthToken(this.tokenType, this.accessToken);

  OauthToken.fromJson(Map<String, dynamic> json)
      : tokenType = json['token_type'],
        accessToken = json['access_token'];
}
