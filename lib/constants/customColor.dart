import 'package:flutter/material.dart';

class CustomColor {
  static const Color darkGray = Color(0xFF777777);
  static const Color brightGray = Color(0xffeaeaea);
  static const Color darkBlueGray = Color(0xff869bb3);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xFF000000);
  static const Color darkGreen = Color(0xFF126b1d);

  static Color getColor(String colorName) {
    return _getColorMap()[colorName] ?? const Color(0xFF000000);
  }

  static Map<String, Color> _getColorMap() {
    return {
      'darkGray': darkGray,
      'brightGray': brightGray,
      'darkBlueGray': darkBlueGray,
      'white': white,
      'black': black,
      'darkGreen': darkGreen,
    };
  }
}
