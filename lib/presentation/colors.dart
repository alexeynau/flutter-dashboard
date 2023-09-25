import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ThemeColors {
  ThemeColors();

  // Primary actions, emphasizing navigation elements,
  // backgrounds, text, etc.
  Color get primary => Color.fromARGB(242, 29, 104, 29);
  Color get selected => Color.fromARGB(255, 112, 186, 107);
  Color get primarytext => Color.fromARGB(241, 37, 40, 37);
  Color get secondary => Color.fromARGB(255, 255, 255, 255);

  // Backgrounds
  Color get background01 => Color.fromARGB(255, 250, 245, 245);
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

  //gradient for 3 graph
  Color get firstgrad3 => Color.fromARGB(237, 48, 13, 39);
  Color get secondgrad3 => Color.fromARGB(255, 53, 5, 42);

  //gradient for 4 graph
  Color get firstgrad4 => Color.fromARGB(238, 65, 57, 218);
  Color get secondgrad4 => Color.fromARGB(255, 10, 85, 171);

  //gradient for 5 graph
  Color get firstgrad5 => Color.fromARGB(238, 210, 78, 197);
  Color get secondgrad5 => Color.fromARGB(255, 224, 21, 193);

  //gradient for 6 graph
  Color get firstgrad6 => Color.fromARGB(239, 210, 78, 78);
  Color get secondgrad6 => Color.fromARGB(255, 224, 21, 24);

  //gradient for 7 graph
  Color get firstgrad7 => Color.fromARGB(238, 78, 157, 210);
  Color get secondgrad7 => Color.fromARGB(255, 21, 136, 224);

  //gradient for 8 graph
  Color get firstgrad8 => Color.fromARGB(238, 78, 210, 206);
  Color get secondgrad8 => Color.fromARGB(255, 21, 210, 224);

  //gradient for 9 graph
  Color get firstgrad9 => Color.fromARGB(238, 22, 63, 32);
  Color get secondgrad9 => Color.fromARGB(255, 5, 73, 24);
  //gradient for 10 graph
  Color get firstgrad10 => Color.fromARGB(238, 53, 55, 11);
  Color get secondgrad10 => Color.fromARGB(255, 45, 46, 2);
  //bg fot tooltip
  Color get tooltipBg => Color.fromARGB(0, 255, 255, 255);
  Color get tooltipBgBar => Color.fromARGB(0, 255, 255, 255);

  //for markets
  Color get export => Color.fromARGB(255, 54, 147, 101);
  Color get sng => Color.fromARGB(255, 10, 54, 7);
  Color get innerMarket => Color.fromARGB(255, 219, 250, 62);
  Color get justAddSmth => Color.fromARGB(255, 41, 14, 158);
  Color get outMarket => Color.fromARGB(255, 152, 3, 3);

  // for bar
  Color get barColor => Color.fromARGB(255, 202, 32, 182);
}
