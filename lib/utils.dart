import 'dart:io';

import 'package:path/path.dart' as path;

class Utils {
  static String getFileNameWithExtension(File file) {
    if (file.existsSync()) {
      //To get file name without extension
      //path.basenameWithoutExtension(file.path);

      //return file with file extension
      return path.basename(file.path);
    } else {
      return null;
    }
  }

  static String getFileSize(File file) {
    if (file.existsSync()) {
      //To get file name without extension
      //path.basenameWithoutExtension(file.path);
      int fileSizeInBytes = file.lengthSync();
      var fileSizeInKB = fileSizeInBytes / 1024;
      // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
      var fileSizeInMB = fileSizeInKB / 1024;
      //return file with file extension
      return fileSizeInMB.toStringAsFixed(2) + ' MB';
    } else {
      return null;
    }
  }

  static RegExp intRegex() {
    return RegExp(r'[^0-9]');
  }
}
