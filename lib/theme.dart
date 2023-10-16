import 'package:flutter/material.dart';

const String fontFamily = 'Roboto';
const LinearGradient loginBackgroundColor = LinearGradient(
  colors: <Color>[
    Color(0xFF6A4B12),
    Color(0xFF735114),
    Color(0xFF825C16),
    Color(0xFF8F6518),
    Color(0xFFA0711C),
    Color(0xFFBB8129),
    Color(0xFFD29034),
    Color(0xFFE99E40),
    Color(0xFFFFAB4A),
    Color(0xFFFFB968),
    // Color(0xFFFDC788),
    // Color(0xFFFAD8B0),
    // Color(0xFFFCE8D2),
    // Color(0xFFFDF5EC),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

Color dongker = Color(0xFF0D47A1);
Color greyColor = Color(0xff808BA2);

TextStyle tabTitleTextStyle = TextStyle(
  color: dongker,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

const LinearGradient buttonBackgroundColor = LinearGradient(
  colors: <Color>[
    Color(0xFFD29034),
    Color(0xFFE99E40),
    Color(0xFFD29034),
  ],
);

const LinearGradient appBarBackgroundColor = LinearGradient(
  colors: <Color>[
    Color(0xFFA0711C),
    Color(0xFF735114),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

const Color disabledListBackgroundColor = Color(0xFFEBE3D7);
const Color listOddBackgroundColor = Color(0xFFC2A777);
const Color listEvenBackgroundColor = Color(0xFFE1D3BA);
const Color primaryColor = Color(0xFF825C16);
const Color primaryVariantColor = Color(0xFF6A4B12);
const Color secondaryColor = Color(0xFFE99E40);
const Color secondaryVariantColor = Color(0xFFBB8129);
const Color scaffoldBackgroundColor = Color(0xFFFDF5EC);
const Color triadicColor = Color(0xFF147352);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF333333);
const Color errorColor = Color(0xFFB00020);

final ColorScheme colorScheme = new ColorScheme(
    primary: primaryColor,
    primaryVariant: primaryVariantColor,
    secondary: secondaryColor,
    secondaryVariant: secondaryVariantColor,
    surface: white,
    background: scaffoldBackgroundColor,
    error: errorColor,
    onPrimary: white,
    onSecondary: black,
    onSurface: black,
    onBackground: black,
    onError: white,
    brightness: Brightness.light);

ThemeData defaultTheme() {
  TextTheme defaultTextTheme(TextTheme base) {
    return base.copyWith(
        caption: base.caption
            .copyWith(fontFamily: fontFamily, color: black, fontSize: 12.0),
        headline: base.title.copyWith(
            fontFamily: fontFamily,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: black),
        title: base.title.copyWith(fontFamily: fontFamily, color: black),
        button: base.button.copyWith(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Colors.white));
  }

  final ThemeData base = ThemeData(
      accentColor: secondaryColor,
      primaryColor: primaryColor,
      colorScheme: colorScheme,
      indicatorColor: primaryColor, //line below tab bar
      errorColor: errorColor,
      buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          colorScheme: colorScheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryIconTheme: IconThemeData(color: white),
      iconTheme: IconThemeData(color: white),
      bottomAppBarTheme: BottomAppBarTheme(color: primaryColor),
      accentIconTheme: IconThemeData(color: white),
      inputDecorationTheme:
          InputDecorationTheme(fillColor: white, filled: true),
      dividerTheme: DividerThemeData(space: 0, color: scaffoldBackgroundColor));

  return base.copyWith(textTheme: defaultTextTheme(base.textTheme));

}
