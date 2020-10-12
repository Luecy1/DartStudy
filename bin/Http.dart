import 'package:http/http.dart' as http;

Future<void> main() async {
  var dataURL = 'https://jsonplaceholder.typicode.com/posts';
  var response = await http.get(dataURL);
  print(response.body);
}