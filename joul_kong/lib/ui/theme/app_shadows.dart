import 'package:flutter/material.dart';

class AppShadows {
  static const BoxShadow soft = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  static const BoxShadow medium = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 16,
    offset: Offset(0, 6),
  );

  static const BoxShadow strong = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 24,
    offset: Offset(0, 10),
  );
}
