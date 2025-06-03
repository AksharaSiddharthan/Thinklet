import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewNoteScreen extends StatefulWidget {
  final Function(String, String) addNote;

  const NewNoteScreen({super.key, required this.addNote});

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void saveNote() {
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    if (title.isNotEmpty || content.isNotEmpty) {
      widget.addNote(title, content);
      Navigator.pop(context, true);
    }
  }

  void cancelNote() {
    Navigator.pop(context, false);
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
                // Back Arrow
               
                 IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,size:32,color:Color.fromARGB(223, 110, 104, 152),),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

                // Input fields in expanded area
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
                              borderSide:
                                  const BorderSide(color: Colors.white),
                            ),
                          ),
                          style: GoogleFonts.lekton(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Icon Buttons Row
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Save Icon
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blueGrey,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.save, color: Colors.white),
                        onPressed: () {
                          final title = titleController.text.trim();
                          final content = contentController.text.trim();
                          if (title.isNotEmpty && content.isNotEmpty) {
                            widget.addNote(title, content);
                            Navigator.pop(context, true);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Delete Icon
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blueGrey,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context); // Don't add note
                        },
                      ),
                    ),
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