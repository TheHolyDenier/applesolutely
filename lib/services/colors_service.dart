import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

class UtilsService {
  static HashMap<dynamic, Color> dictionaryColors = HashMap();

  static addDictionaryColor(dynamic key) {
    if (UtilsService.dictionaryColors.containsKey(key)) return;
    Color black = Colors.black;
    Color color = UtilsService.genRandomColor();

    var blackLuminance =
        UtilsService.luminance(r: black.red, b: black.blue, g: black.green);
    var colorLiminance =
        UtilsService.luminance(r: color.red, b: color.blue, g: color.green);

    var ratio = colorLiminance > blackLuminance
        ? ((blackLuminance + 0.05) / (colorLiminance + 0.05))
        : ((colorLiminance + 0.05) / (blackLuminance + 0.05));

    if (ratio < 1 / 3) {
      UtilsService.dictionaryColors[key] = color;
    } else {
      UtilsService.addDictionaryColor(key);
    }
  }

  static luminance({required int r, required int g, required int b}) {
    var a = [r.toDouble(), g.toDouble(), b.toDouble()].map((v) {
      v /= 255;
      return v <= 0.03928 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4);
    }).toList();
    return a[0] * 0.2126 + a[1] * 0.7152 + a[2] * 0.0722;
  }

  static Color genRandomColor() =>
      Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
}
