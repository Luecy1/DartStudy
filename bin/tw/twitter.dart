import 'package:http_auth/http_auth.dart' as http_auth;

import 'key.dart';

void main() async {
  final client = http_auth.BasicAuthClient(API_KEY, API_KEY_SECRET);

  final request_param = {'grant_type': 'client_credentials'};

  final response = await client.post(
    'https://api.twitter.com/oauth2/token',
    body: request_param,
  );

  print(response.body);
}
