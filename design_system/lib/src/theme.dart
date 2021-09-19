import 'package:flutter/material.dart';


ThemeData get darkTheme => ThemeData(
      scaffoldBackgroundColor: kBlackColor,
      primaryColor: kOrangeColor,
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: kOrangeColor,
        primary: Colors.white
      ),
      primarySwatch: Colors.deepOrange, // Testar isso
      buttonTheme: const ButtonThemeData(buttonColor: kOrangeColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            
            foregroundColor: MaterialStateProperty.resolveWith((states) => kWhiteColor),
            backgroundColor: MaterialStateProperty.resolveWith((states) => kOrangeColor),

      )),
          textTheme: TextTheme(),
        //   ElevatedButton.styleFrom(
        //     onSurface: kWhiteColor,
        //     onPrimary: kWhiteColor,
        //     textStyle: TextStyle(color: Colors.white,),
        // primary: kOrangeColor,
        
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => kOrangeColor),
        ),
      ),
      brightness: Brightness.dark,
    );

ThemeData get lightTheme => ThemeData();

const Color kWhiteColor = Color(0xFF333333);
const Color kYellowColor = Color(0xFF333333);
const Color kOrangeColor = Color(0xFFf47031);
const Color kGreyColor = Color(0xFF333333);
const Color kBlackColor = Color(0xFF333333);
