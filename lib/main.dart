import 'package:app_agenda/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Agenda",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff202d36),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    ),
  );
}
