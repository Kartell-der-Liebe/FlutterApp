import 'dart:ui' show Color;

import 'package:flutter/material.dart';

class MyColors {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  // ignore: unused_element
  MyColors._();

  /// Completely invisible.
  static const Color eineLiebeDunkel = Color(0x0FF002C3C);

  static const MaterialColor eineLiebeDunkelMaterialColor = MaterialColor(
    _pinkPrimaryValue,
    <int, Color>{},
  );
  static const int _pinkPrimaryValue = 0x0FF002C3C;

  static const Color eineLiebehell = Color(0xFFFDEA04);

}