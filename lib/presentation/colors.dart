import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ThemeColors {
  ThemeColors();

  // Primary actions, emphasizing navigation elements,
  // backgrounds, text, etc.
  Color get primary => Color.fromARGB(242, 29, 104, 29);
  // Color get selected => Color.fromARGB(255, 112, 186, 107);
  Color get selected => Color.fromARGB(255, 7, 144, 101);
  Color get primarytext => Color.fromARGB(241, 37, 40, 37);
  Color get secondary => Color.fromARGB(255, 255, 255, 255);

  // Backgrounds
  Color get background01 => Color.fromARGB(255, 210, 202, 202);
  Color get background02 => Color.fromARGB(255, 112, 186, 107);
  Color get background03 => const Color(0xFF1F222A);

  //gradient for graphs
  Color get firstgrad => Color.fromARGB(242, 29, 104, 29);
  Color get secondgrad => Color.fromARGB(255, 112, 186, 107);

  //grid lines colors
  Color get maingridcolor => Color.fromARGB(104, 88, 86, 86);
  Color get maingridbordercolor => Color.fromARGB(91, 0, 0, 0);

  //gradient for second graph
  Color get firstgradSec => Color.fromARGB(239, 210, 78, 78);
  Color get secondgradSec => Color.fromARGB(255, 224, 21, 24);

  //gradient for 3 graph
  Color get firstgrad3 => Color.fromARGB(236, 114, 30, 93);
  Color get secondgrad3 => Color.fromARGB(255, 99, 11, 79);

  //gradient for 4 graph
  Color get firstgrad4 => Color.fromARGB(238, 65, 57, 218);
  Color get secondgrad4 => Color.fromARGB(255, 10, 85, 171);

  //gradient for 5 graph
  Color get firstgrad5 => Color.fromARGB(238, 210, 78, 197);
  Color get secondgrad5 => Color.fromARGB(255, 224, 21, 193);

  //gradient for 6 graph
  Color get firstgrad6 => Color.fromARGB(238, 234, 165, 165);
  Color get secondgrad6 => Color.fromARGB(255, 235, 159, 161);

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
  Color get tooltipBg => Color.fromARGB(255, 233, 230, 230);
  Color get tooltipBgBar => Color.fromARGB(0, 255, 255, 255);

  //for markets
  Color get export => Color.fromARGB(255, 54, 147, 101);
  Color get sng => Color.fromARGB(255, 10, 54, 7);
  Color get innerMarket => Color.fromARGB(255, 219, 250, 62);
  Color get justAddSmth => Color.fromARGB(255, 41, 14, 158);
  Color get outMarket => Color.fromARGB(255, 152, 3, 3);

  // for bar
  Color get barColor => Color.fromARGB(255, 7, 144, 101);

  // for pie
  Color get pieTextColor => Color.fromARGB(255, 255, 255, 255);
  Color get pieBg1 => const Color.fromARGB(255, 180, 23, 23);
  Color get pieBg3 => Color.fromARGB(255, 197, 155, 38);
  Color get pieBg2 => Color.fromARGB(255, 225, 93, 40);
  Color get pieBg4 => Color.fromARGB(255, 149, 182, 43);
  Color get pieBg5 => Color.fromARGB(255, 50, 166, 41);
  Color get pieBg6 => Color.fromARGB(255, 41, 178, 133);
  Color get pieBg7 => Color.fromARGB(255, 43, 156, 168);
  Color get pieBg8 => Color.fromARGB(255, 43, 46, 157);
  Color get pieBg9 => Color.fromARGB(255, 120, 47, 169);
  Color get pieBg10 => Color.fromARGB(255, 160, 39, 164);

  // for waterflow
  Color get add => Color.fromARGB(255, 58, 207, 13);
  Color get delete => Color.fromARGB(255, 197, 3, 3);
  Color get summary => Color.fromARGB(255, 37, 80, 172);
  Color get addText => Color.fromARGB(255, 8, 19, 5);
  Color get deleteText => Color.fromARGB(255, 255, 254, 254);
  Color get summaryText => Color.fromARGB(255, 255, 255, 255);
  Color get zeroText => Color.fromARGB(255, 15, 16, 14);
  //
  Color get opacityColor => Color.fromARGB(0, 15, 16, 14);
  Color get greyText => Color.fromARGB(255, 143, 144, 142);
}
