import 'dart:math';

void main() async {
  final taskA = task('taskA');
  final taskB = task('taskB');
  print('both complete ${await taskA} ${await taskB}');
}

Future<String> task(String name) async {
  print('Start $name');
  final waitTime = Random().nextInt(10);
  print('sleep $waitTime');
  await Future.delayed(Duration(seconds: waitTime));
  print('Complete $name');
  return name;
}
