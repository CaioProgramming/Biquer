import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:path/path.dart' as path;
import 'package:tinycolor/tinycolor.dart';

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

  static setBarAndNavColor(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Utils.barcolor(context));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor));
  }

  static Color barcolor(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    Brightness whichMode = mode.brightness;
    switch (whichMode) {
      case Brightness.dark:
        return TinyColor(ThemeData.dark().scaffoldBackgroundColor)
            .darken(10)
            .color;
      case Brightness.light:
        return TinyColor(Theme.of(context).scaffoldBackgroundColor)
            .lighten(10)
            .color;
        break;
      default:
        return TinyColor(Theme.of(context).scaffoldBackgroundColor)
            .lighten(10)
            .color;
    }
  }
}
