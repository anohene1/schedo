import "package:flutter/material.dart";
import "../components/components.dart";

ThemeData darkTheme() {
  return ThemeData(
      brightness: Brightness.dark,
      primaryColor: purple,
      accentColor: pink,
      scaffoldBackgroundColor: darkBackground,
      fontFamily: "Gilroy",
      buttonColor: darkBlue,
      primaryColorLight: Colors.white,
    dividerColor: darkThemeGrey
  );
}