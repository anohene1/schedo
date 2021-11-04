import "package:flutter/material.dart";
import "../components/components.dart";

ThemeData darkTheme() {
  return ThemeData(
      brightness: Brightness.dark,
      primaryColor: purple,
      accentColor: pink,
      scaffoldBackgroundColor: darkBackground,
      fontFamily: "Gilroy",
      buttonColor: lightpurple.withOpacity(0.01),
      cardColor: purple.withOpacity(0.1),
      canvasColor: purple.withOpacity(0.3),
      primaryColorLight: Colors.white,
    dividerColor: darkThemeGrey
  );
}