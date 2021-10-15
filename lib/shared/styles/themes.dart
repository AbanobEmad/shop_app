import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 0,
  ),
  textTheme: GoogleFonts.tekoTextTheme(TextTheme(
    bodyText1:TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Colors.black
    ),
    bodyText2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black54
    ),
  ),
),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.deepPurple.withOpacity(.5),
    elevation: 20,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey
  )
);

ThemeData darkTheme =ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white
        )
    )
);