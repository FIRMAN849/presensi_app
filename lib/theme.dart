import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 30.0;

Color primaryColor = const Color(0xffF65B19);
Color secondaryColor = const Color(0xffF6A07B);
Color primaryTextColor = const Color(0xff404852);
Color secondaryTextColor = const Color(0xffc7c7c7);
Color whiteTextColor = const Color(0xffffffff);
Color bgWhite = const Color(0xffffffff);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteTextColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w800;
