import 'dart:ui' show Color;

import 'package:flutter/material.dart';

class MyColors {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  // ignore: unused_element
  MyColors._();

  /// Completely invisible.
  static const Color eineLiebeDunkel = Color(0x0FF002C3C);

  static const _blackPrimaryValue = 0x0FF002C3C;

  static const MaterialColor eineLiebeDunkelMaterialApp = const MaterialColor(
    _blackPrimaryValue,
    const <int, Color>{
      50:  const Color(0x8C002C3C),
      100: const Color(0x99002C3C),
      200: const Color(0xA6002C3C),
      300: const Color(0xB3002C3C),
      400: const Color(0xBF002C3C),
      500: const Color(0xCC002C3C),
      600: const Color(0xD9002C3C),
      700: const Color(0xE6002C3C),
      800: const Color(0xF2002C3C),
      900: const Color(_blackPrimaryValue),
    },
  );

  static const hellPrimaryValue = 0xFFFDEA04;

  static const MaterialColor eineLiebeHellMaterialApp = const MaterialColor(
    hellPrimaryValue,
    const <int, Color>{
      50:  const Color(0x8CFDEA04),
      100: const Color(0x99FDEA04),
      200: const Color(0xA6FDEA04),
      300: const Color(0xB3FDEA04),
      400: const Color(0xBFFDEA04),
      500: const Color(0xCCFDEA04),
      600: const Color(0xD9FDEA04),
      700: const Color(0xE6FDEA04),
      800: const Color(0xF2FDEA04),
      900: const Color(hellPrimaryValue),
    },
  );

  static const Color eineLiebehell = Color(0xFFFDEA04);

}