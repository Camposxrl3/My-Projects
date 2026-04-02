import 'package:flutter/material.dart';

List<Color> mainColors = [
  Colors.black,
  Color.fromARGB(255, 228, 224, 224),
  Color.fromARGB(255, 255, 153, 0),
  Color.fromARGB(255, 134, 65, 0),
  Colors.transparent,
  Color.fromARGB(255, 51, 51, 51),
];

List<TextStyle> textStyles = [
  TextStyle(fontSize: 25, color: mainColors[0], fontFamily: "Audiowide"),
  TextStyle(fontSize: 14, color: mainColors[1], fontFamily: "Audiowide"),
  TextStyle(fontSize: 12, color: mainColors[1], fontFamily: "Audiowide"),
  TextStyle(
    fontSize: 12,
    color: mainColors[1],
    fontFamily: "Audiowide",
    fontFeatures: [FontFeature.tabularFigures()],
  ),
  TextStyle(fontSize: 18, color: mainColors[1], fontFamily: "Audiowide"),
];

final ThemeData themeData = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: mainColors[0],
  colorScheme: ColorScheme.dark(
    primary: mainColors[1],
    surface: mainColors[0],
    surfaceTint: mainColors[4],
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: textStyles[0],
    backgroundColor: mainColors[3],
    foregroundColor: mainColors[0],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.vertical(bottom: Radius.circular(10)),
    ),
    actionsIconTheme: IconThemeData(color: mainColors[0]),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: mainColors[1],
    unselectedItemColor: mainColors[0],
    elevation: 0,
    selectedLabelStyle: textStyles[2],
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(),
);
