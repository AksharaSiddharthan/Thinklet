import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/note_model.dart'; // Make sure this has @HiveType etc.
import 'package:google_fonts/google_fonts.dart';
import 'display_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register the adapter
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());

  // Open the notesBox just once here
  await Hive.openBox<NoteModel>('notesBox');

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
          bodyColor: const Color.fromARGB(223, 49, 66, 95),
        ),
      ),
      home: const DisplayScreen(),
    );
  }
}
