import 'package:app_agenda/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Agenda",
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff20c065),
          onPrimary: Colors.white,
          secondary: Color(0xff20c065),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Color(0xff0a1014),
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xff0a1014),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xff0a1014),
          elevation: 0,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff0a1014),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: true,
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color(0xFF202d36),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: const HomePage(),
    ),
  );
}
