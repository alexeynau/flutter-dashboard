import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ThemeColors {
  ThemeColors();

  // Primary actions, emphasizing navigation elements,
  // backgrounds, text, etc.
  Color get primary => const Color.fromARGB(242, 29, 104, 29);
  Color get primaryWithOpacity => const Color.fromARGB(0, 55, 165, 179);
  // Color get selected => Color.fromARGB(255, 112, 186, 107);
  Color get selected => const Color.fromARGB(255, 7, 144, 101);
  Color get primarytext => const Color.fromARGB(241, 37, 40, 37);
  Color get secondary => const Color.fromARGB(255, 255, 255, 255);

  // Backgrounds
  Color get background01 => const Color.fromARGB(255, 210, 202, 202);
  Color get background02 => const Color.fromARGB(255, 112, 186, 107);
  Color get background03 => const Color(0xFF1F222A);

  //gradient for graphs
  Color get firstgrad => const Color.fromARGB(242, 29, 104, 29);
  Color get secondgrad => const Color.fromARGB(255, 112, 186, 107);

  //grid lines colors
  Color get maingridcolor => const Color.fromARGB(104, 88, 86, 86);
  Color get maingridbordercolor => const Color.fromARGB(91, 0, 0, 0);

  //gradient for second graph
  Color get firstgradSec => const Color.fromARGB(239, 210, 78, 78);
  Color get secondgradSec => const Color.fromARGB(255, 224, 21, 24);

  //gradient for 3 graph
  Color get firstgrad3 => const Color.fromARGB(236, 114, 30, 93);
  Color get secondgrad3 => const Color.fromARGB(255, 99, 11, 79);

  //gradient for 4 graph
  Color get firstgrad4 => const Color.fromARGB(238, 65, 57, 218);
  Color get secondgrad4 => const Color.fromARGB(255, 10, 85, 171);

  //gradient for 5 graph
  Color get firstgrad5 => const Color.fromARGB(238, 210, 78, 197);
  Color get secondgrad5 => const Color.fromARGB(255, 224, 21, 193);

  //gradient for 6 graph
  Color get firstgrad6 => const Color.fromARGB(238, 234, 165, 165);
  Color get secondgrad6 => const Color.fromARGB(255, 235, 159, 161);

  //gradient for 7 graph
  Color get firstgrad7 => const Color.fromARGB(238, 78, 157, 210);
  Color get secondgrad7 => const Color.fromARGB(255, 21, 136, 224);

  //gradient for 8 graph
  Color get firstgrad8 => const Color.fromARGB(238, 78, 210, 206);
  Color get secondgrad8 => const Color.fromARGB(255, 21, 210, 224);

  //gradient for 9 graph
  Color get firstgrad9 => const Color.fromARGB(238, 22, 63, 32);
  Color get secondgrad9 => const Color.fromARGB(255, 5, 73, 24);
  //gradient for 10 graph
  Color get firstgrad10 => const Color.fromARGB(238, 53, 55, 11);
  Color get secondgrad10 => const Color.fromARGB(255, 45, 46, 2);
  //bg fot tooltip
  Color get tooltipBg => const Color.fromARGB(255, 233, 230, 230);
  Color get tooltipBgWithOp => const Color.fromARGB(130, 203, 199, 199);
  Color get tooltipBgBar => const Color.fromARGB(0, 255, 255, 255);

  //for markets
  Color get export => const Color.fromARGB(255, 54, 147, 101);
  Color get sng => const Color.fromARGB(255, 10, 54, 7);
  Color get innerMarket => const Color.fromARGB(255, 219, 250, 62);
  Color get justAddSmth => const Color.fromARGB(255, 41, 14, 158);
  Color get outMarket => const Color.fromARGB(255, 152, 3, 3);

  // for bar
  Color get barColor => const Color.fromARGB(255, 7, 144, 101);

  // for pie
  Color get pieTextColor => const Color.fromARGB(255, 255, 255, 255);
  Color get pieBg1 => const Color.fromARGB(255, 180, 23, 23);
  Color get pieBg3 => const Color.fromARGB(255, 197, 155, 38);
  Color get pieBg2 => const Color.fromARGB(255, 225, 93, 40);
  Color get pieBg4 => const Color.fromARGB(255, 149, 182, 43);
  Color get pieBg5 => const Color.fromARGB(255, 50, 166, 41);
  Color get pieBg6 => const Color.fromARGB(255, 41, 178, 133);
  Color get pieBg7 => const Color.fromARGB(255, 43, 156, 168);
  Color get pieBg8 => const Color.fromARGB(255, 43, 46, 157);
  Color get pieBg9 => const Color.fromARGB(255, 120, 47, 169);
  Color get pieBg10 => const Color.fromARGB(255, 160, 39, 164);

  // for waterflow
  Color get add => const Color.fromARGB(255, 58, 207, 13);
  Color get delete => const Color.fromARGB(255, 197, 3, 3);
  Color get summary => const Color.fromARGB(255, 37, 80, 172);
  Color get addText => const Color.fromARGB(255, 8, 19, 5);
  Color get deleteText => const Color.fromARGB(255, 255, 254, 254);
  Color get summaryText => const Color.fromARGB(255, 255, 255, 255);
  Color get zeroText => const Color.fromARGB(255, 15, 16, 14);
  //
  Color get opacityColor => const Color.fromARGB(0, 15, 16, 14);
  Color get greyText => const Color.fromARGB(255, 143, 144, 142);
  // Color get navigationButtonColor => Color.fromARGB(255, 50, 166, 41);

  Color get navigationButtonColor => const Color.fromARGB(255, 9, 137, 84);
  Color get navigationButtonText => const Color.fromARGB(255, 254, 255, 252);
}
