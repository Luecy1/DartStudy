import 'dart:io';

void main() async {
  final deviceList = await getDeviceList();
  deviceList.forEach((element) {
    print(element);
  });
}

Future<List<Device>> getDeviceList() async {
  final adb = await Process.run('adb', ['devices', '-l']);
  if (adb.exitCode == 0) {
    final result = (adb.stdout as String);

    final deviceList = result
        .split('\r\n')
        .where((element) {
          return !element.contains('List of devices attached');
        })
        .where((element) => element.isNotEmpty)
        .map((e) {
          final split = e.split(RegExp(' +'));
          final serialId = split[0];
          final modelName = split[3].split(':')[1];
          return Device(serialId, modelName);
        });
    return deviceList.toList();
  } else {
    throw Exception('adb command error \n${adb.stderr}');
  }
}

class Device {
  final String serial;
  final String modelName;

  Device(this.serial, this.modelName);

  @override
  String toString() {
    return 'Device{serial: $serial, modelName: $modelName}';
  }
}
