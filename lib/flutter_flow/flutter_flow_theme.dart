// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) => LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color secondaryText;

  Color primaryDark;
  Color background;
  Color gray;
  Color gray200;
  Color red200;
  Color darkBlue;

  TextStyle get title1 => GoogleFonts.getFont(
        'Lato',
        color: primaryDark,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      );
  TextStyle get title2 => GoogleFonts.getFont(
        'Lato',
        color: primaryDark,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
  TextStyle get title3 => GoogleFonts.getFont(
        'Lato',
        color: primaryDark,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Lato',
        color: darkBlue,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Lato',
        color: primaryDark,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Lato',
        color: primaryDark,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Lato',
        color: gray,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  Color primaryColor = const Color(0xFF376AED);
  Color secondaryColor = const Color(0xFF39D2C0);
  Color tertiaryColor = const Color(0xFFFFFFFF);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  Color primaryDark = Color(0xFF0D253C);
  Color background = Color(0xFFF4F7FF);
  Color gray = Color(0xFFD9DFEB);
  Color gray200 = Color(0xFFDBE2E7);
  Color red200 = Color(0xFFFF3743);
  Color darkBlue = Color(0xFF2151CD);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              height: lineHeight,
            );
}
