import 'package:flutter/material.dart';
import 'package:flutter_tflite_examples/common/helpers/get_swatch.dart';

class ColorPalette {
  ColorPalette._();

  static const int primaryColor = 0xff6ACAC6;
  static const int primaryColorDark = 0xff08ACA5;

  static MaterialColor primaryMaterialColor = getSwatch(const Color.fromARGB(255, 0, 0, 0));
  static MaterialColor primaryMaterialColorDark = getSwatch(const Color.fromARGB(255, 4, 6, 6));

  static const int secondaryColor = 0xff3544C4;

  static const Color grey100Color = Color(0xFFEEEEEE);
  static const Color grey200Color = Color(0xFFEEEEEE);
  static const Color grey300Color = Color(0xFFE0E0E0);
  static const Color grey400Color = Color(0xFFBDBDBD);
  static const Color grey500Color = Color(0xFF9E9E9E);
  static const Color grey600Color = Color(0xFF757575);
  static const Color grey700Color = Color(0xFF616161);
  static const Color grey800Color = Color(0xFF424242);
  static const Color grey900Color = Color(0xFF212121);

  static const Color black = Colors.black;
  static const Color grey = Color.fromARGB(255, 123, 126, 130);
  static const Color white = Colors.white;

  static const Color fillColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color blue = Colors.blue;
  static const Color green = Colors.green;
  static const Color bg = Color.fromRGBO(247, 247, 247, 1);
  static const Color transparent = Colors.transparent;

  static const Color red = Color.fromARGB(255, 248, 42, 38);
  static const Color error100Color = Color(0xFFFF5252);
  static const Color btn = Color.fromRGBO(57, 62, 70, 1);

  static const Color info = Color.fromARGB(255, 42, 42, 43);

  static const Color newPrimary = Color.fromRGBO(17, 119, 170, 1);
  static const Color homeBg = Color.fromARGB(255, 216, 230, 241);
  static const Color indigo = Colors.indigo;
  static final Color indigoShade100 = Colors.indigo[100]!;
  static final Color blueShade100 = Colors.blue[100]!;
  static const Color bgLight = Color.fromARGB(255, 243, 244, 248);

  static const Color borderButtonBg = Color.fromRGBO(242, 251, 255, 1);
  static const Color circleAvatarBg = Color.fromARGB(255, 215, 241, 253);
  static const Color whiteShadow = Color.fromARGB(255, 184, 183, 183);

  static const Color failedContainerBg = Color.fromRGBO(255, 230, 219, 1);
  static const Color assignScannedPalletToShelves = Color.fromRGBO(195, 219, 230, 1);
  static const Color orange = Colors.orange;

  static const Color customPopUpBg = Color.fromRGBO(243, 250, 244, 1);
  static const Color fillColorRfidTextField = Color.fromRGBO(247, 247, 247, 1);
  static const Color greenBackground = Color.fromRGBO(217, 248, 220, 1);
}