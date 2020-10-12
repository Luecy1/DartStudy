import 'dart:io';

void main() async {
  final file = File('bin/File.dart');
  final lines = await file.readAsLines();

  lines.forEach((element) {
    print(element);
  });

  file.openRead().listen((event) {

    print(event.length);
    for (var value in event) {
      print( String.fromCharCode(value));
    }
  });

  //  file.readAsLines().then((value){
  //   for (var value1 in value) {
  //     print(value1);
  //   }
  // });
}