import "package:flutter/material.dart";
import "../components/components.dart";

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: purple,
    accentColor: pink,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Gilroy",
    buttonColor: lightGrey,
    cardColor: lightpurple,
    canvasColor: mediumGrey,
    primaryColorLight: lightThemeText,
    dividerColor: grey
  );
}