import 'package:flutter/material.dart';

const btnBgOrange = Color(0xFFF57C00);
const btnBgBlue = Color(0xFF2196F3);
const bgBlue = Color(0xFF2196F3);
const bgWhite = Color(0xffffffff);
const bgOrange = Color(0xFFFF9800);
Color bgGrey = Color(0xff808BA2);
Color bgBlack = Color(0xff2C3A59);

const bgGradientLogin = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[
    Color(0xFF42A5F5),
    Color(0xFF1E88E5),
    Color(0xFF1976D2),
  ],
);

const bgGradient = LinearGradient(
  colors: <Color>[
    Color(0xFF1565C0),
    Color(0xFF1976D2),
    Color(0xFF1E88E5),
    Color(0xFF2196F3),
    Color(0xFF42A5F5),
    Color(0xFF64B5F6),
    Color(0xFF90CAF9),
    Color(0xFFBBDEFB),
    Color(0xFFFFE0B2),
    Color(0xFFFFE0B2),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const btnGradientColor = LinearGradient(
  colors: <Color>[
    Color(0xFFF57C00),
    Color(0xFFFF9800),
    Color(0xFFF57C00),
  ],
);

const bgGradientAppBar = LinearGradient(
  colors: <Color>[
    Color(0xFF0099FF),
    Color(0xFF0033CC),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
const bgInversGradientAppBar = LinearGradient(
  colors: <Color>[
    Color(0xFF0033CC),
    Color(0xFF0099FF),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
const bgGradientPage = LinearGradient(
  colors: [
    Color(0xFFF0F8FF),
    Color(0xFFF0F8FF),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
const bgGradientPageWhite = LinearGradient(
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const bgGradientPageOrange = LinearGradient(
  colors: [
    Color(0xFFFFE0B2),
    Color(0xFFFFE0B2),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const bgGradientPageBlue = LinearGradient(
  colors: [
    Color(0xFFBBDEFB),
    Color(0xFFBBDEFB),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

TextStyle headerTextStyle = TextStyle(
  color: bgBlack,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 18,
);

TextStyle lineTextStyle = TextStyle(
  color: bgBlack,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
  fontSize: 14,
);

TextStyle subTitleTextStyle = TextStyle(
  color: bgGrey,
  fontWeight: FontWeight.w500,
  fontSize: 13,
);
