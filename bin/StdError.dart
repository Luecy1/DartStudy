import 'dart:io';

void main() {
  stdout.writeln('std out');
  stderr.writeln('error');

  final read = stdin.readLineSync();
  print('you write $read');
}
