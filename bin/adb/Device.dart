import 'dart:io';

void main() async {
  final devicesResult = await Process.run('adb', ['devices', '-l']);

  if (devicesResult.exitCode != 0) {
    throw Exception('adb error no devices');
  }

  (devicesResult.stdout as String).split('\r\n').where((element) {
    element.matchAsPrefix("list");
  }).forEach((element) {
    print(element);
  });
}
