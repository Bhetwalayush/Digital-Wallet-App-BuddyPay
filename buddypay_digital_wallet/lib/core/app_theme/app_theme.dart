import 'package:buddypay_digital_wallet/features/homepage/presentation/view_models/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData getTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Montserrat Regular',
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black, // Change the text color as needed
              fontSize: 24, // Increase font size for the title
              fontWeight: FontWeight.bold, // Optional: Make the text bold
            ),
            centerTitle: true,
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Colors.white,
            elevation: 5,
            scrimColor: Colors.black54,
            shadowColor: Colors.grey,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
            textColor: Colors.black,
            tileColor: Colors.white,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.black),
            titleMedium: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
            bodySmall: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat Bold',
              ),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        );

      case AppTheme.dark:
        return ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'Montserrat Regular',
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white, // Change the text color as needed
              fontSize: 24, // Increase font size for the title
              fontWeight: FontWeight.bold, // Optional: Make the text bold
            ),
            centerTitle: true,
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Colors.black,
            elevation: 5,
            scrimColor: Colors.black54,
            shadowColor: Colors.white,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.white,
            textColor: Colors.white,
            tileColor: Colors.black,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat Bold',
              ),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        );
      default:
        return ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: const Color(0xff304F50),
          fontFamily: 'Montserrat Regular',
          appBarTheme: const AppBarTheme(
            color: Colors.teal,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white, // Change the text color as needed
              fontSize: 24, // Increase font size for the title
              fontWeight: FontWeight.bold, // Optional: Make the text bold
            ),
            centerTitle: true,
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Colors.teal,
            elevation: 5,
            scrimColor: Colors.black54,
            shadowColor: Colors.white,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.white,
            textColor: Colors.white,
            tileColor: Colors.teal,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat Bold',
              ),
              backgroundColor: const Color(0xFF00C9A7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        );
    }
  }
}
