import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHandler {
  File file;

  Future<void> _fetchFile() async {
    String path = await _localPath;
    file = File('$path/cities.json');
  }

  Future<Map<String, dynamic>> read() async {
    try {
      await _fetchFile();
      String contents = await file.readAsString();
      if (contents.isEmpty || contents == "") throw 'file is empty';
      return jsonDecode(contents);
    } catch (e) {
      throw 'File Exception';
    }
  }

  Future<void> write(Map<String, dynamic> json) async {
    await _fetchFile();
    String jsonEncoded = jsonEncode(json);
    await file.writeAsString(jsonEncoded);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
