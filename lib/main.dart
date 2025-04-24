import 'package:app_agenda/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Agenda",
      theme: ThemeData(
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
        ),
      ),
      home: const HomePage(),
    ),
  );
}
