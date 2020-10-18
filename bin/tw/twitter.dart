import 'dart:convert';

import 'package:http/http.dart' as http;

import 'key.dart';

void main() async {
  final base64encoded =
      base64.encode(latin1.encode('${API_KEY}:${API_KEY_SECRET}'));

  final request_param = {'grant_type': 'client_credentials'};

  final response = await http.post(
    'https://api.twitter.com/oauth2/token',
    headers: {'Authorization': 'Basic $base64encoded'},
    body: request_param,
  );

  print(response.body);
  final oauthToken = OauthToken.fromJson(jsonDecode(response.body));

  final request_param2 = {'Authorization': 'Bearer ${oauthToken.accessToken}'};

  final result = await http.get(
      'https://api.twitter.com/2/users/by/username/Luecy1',
      headers: request_param2);

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
