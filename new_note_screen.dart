import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thinkletapp/models/note_model.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key, required void Function(String title, String content) addNote});

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

void saveNote() async {
  final title = titleController.text.trim();
  final content = contentController.text.trim();

  if (title.isNotEmpty || content.isNotEmpty) {
    final noteBox = await Hive.openBox<NoteModel>('notes'); // corrected box name
    await noteBox.add(NoteModel(title: title, content: content)); // add note properly
    Navigator.pop(context, true); // tells DisplayScreen to refresh
  }
}


  void cancelNote() {
    Navigator.pop(context, false); // do not save
  }

  Widget buildIconButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(223, 110, 104, 152),
        borderRadius: BorderRadius.circular(16), // Square but rounded
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/seaimage1.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        size: 32, color: Color.fromARGB(223, 110, 104, 152)),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: 8),

                  // Title
                  Center(
                    child: Text(
                      'New Note',
                      style: GoogleFonts.pirataOne(fontSize: 64),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input Fields
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF7E9BE),
                            hintText: 'Title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          style: GoogleFonts.lekton(),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: TextField(
                            controller: contentController,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF7E9BE),
                              hintText: 'Write your note...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                            style: GoogleFonts.lekton(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Save & Delete Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildIconButton(icon: Icons.save, onPressed: saveNote),
                      buildIconButton(icon: Icons.delete, onPressed: cancelNote),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

