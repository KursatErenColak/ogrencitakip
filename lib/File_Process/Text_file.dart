import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

class FileProcess {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/metin.txt');
  }

  static Future<File> savetoFile(String text) async {
    final file = await getFile;
    return file.writeAsString(text);
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String metin = await file.readAsString();
      return metin;
    } catch (e) {
      return "Dosya okunurken hata oluştu";
    }
  }
}
