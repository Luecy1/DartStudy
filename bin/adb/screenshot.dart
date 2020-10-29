import 'dart:io';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'env.dart';

Future<void> main() async {
  Intl.defaultLocale = 'ja';
  await initializeDateFormatting('ja_JP');

  final now = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

  final deviceList = await getDeviceList();

  var index = 0;
  for (var device in deviceList) {
    final fileName = '${now}_${index}.png';
    eachDeviceScreenshot(fileName, device);
    index++;
  }
}

void eachDeviceScreenshot(String fileName, String device) async {
  await screenshot(fileName, device);

  final file = File(fileName);
  await file.rename('${SCREEN_SHOT_OUT_PATH}\\$fileName');
}

Future<List<String>> getDeviceList() async {
  final adb = await Process.run('adb', ['devices']);
  if (adb.exitCode == 0) {
    final result = (adb.stdout as String);

    final deviceList = result
        .split('\r\n')
        .where((element) {
          return !element.contains('List of devices attached');
        })
        .where((element) => element.isNotEmpty)
        .map((e) {
          return e.split(RegExp('\t'))[0];
        });
    return deviceList.toList();
  } else {
    throw Exception('adb command error \n${adb.stderr}');
  }
}

Future<void> screenshot(String fileName, String serial) async {
  await Process.run('adb',
      ['-s', serial, 'shell', 'screencap', '-p', '/sdcard/screenshot.png']);
  await Process.run(
      'adb', ['-s', serial, 'pull', '/sdcard/screenshot.png', fileName]);
  await Process.run('adb', ['-s', serial, 'rm', '/sdcard/screenshot.png']);
}
