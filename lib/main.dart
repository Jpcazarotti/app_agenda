import 'package:app_agenda/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Agenda",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff202d36),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xff202d36),
          elevation: 0,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff202d36),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const HomePage(),
    ),
  );
}
