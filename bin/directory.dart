import 'dart:io';

void main() async {
  final thisFile = File(Platform.script.toFilePath());
  final result = await thisFile.parent.list(recursive: true).forEach((element) {
    print(element);
  });
}
