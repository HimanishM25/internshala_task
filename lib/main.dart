import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internshala Task',
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
          foregroundColor: Colors.white,
          //backgroundColor: Colors.grey[300],
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.inter(color:Colors.black,fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        appBarTheme:  AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey[300],
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.inter(color:Colors.black,fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: SearchPage(),
    );
  }
}



