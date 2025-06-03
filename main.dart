import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'display_screen.dart';

void main() {
  runApp(const ThinkletApp());
}

class ThinkletApp extends StatelessWidget {
  const ThinkletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thinklet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.lektonTextTheme().apply(
              bodyColor: Color.fromARGB(223, 49, 66, 95),
            
            ),
        //).
      ),
      home: const DisplayScreen(),
    );
  }
}
