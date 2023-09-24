import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ThemeColors {
  ThemeColors();

  // Primary actions, emphasizing navigation elements,
  // backgrounds, text, etc.
  Color get primary => Color.fromARGB(242, 29, 104, 29);
  Color get primarytext => Color.fromARGB(241, 37, 40, 37);
  Color get secondary => Color.fromARGB(255, 255, 255, 255);

  // Backgrounds
  Color get background01 => Color.fromARGB(255, 193, 193, 195);
  Color get background02 => Color.fromARGB(255, 112, 186, 107);
  Color get background03 => const Color(0xFF1F222A);

  //gradient for graphs
  Color get firstgrad => Color.fromARGB(242, 29, 104, 29);
  Color get secondgrad => Color.fromARGB(255, 112, 186, 107);

  //grid lines colors
  Color get maingridcolor => Color.fromARGB(26, 255, 255, 255);
  Color get maingridbordercolor => Color.fromARGB(91, 0, 0, 0);

  //gradient for second graph
  Color get firstgradSec => Color.fromARGB(239, 210, 78, 78);
  Color get secondgradSec => Color.fromARGB(255, 224, 21, 24);

  //bg fot tooltip
  Color get tooltipBg => Color.fromARGB(237, 253, 253, 253);

  //for markets
  Color get export => Color.fromARGB(255, 54, 147, 101);
  Color get sng => Color.fromARGB(255, 10, 54, 7);
  Color get innerMarket => Color.fromARGB(255, 219, 250, 62);
}
