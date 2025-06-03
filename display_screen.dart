import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_note_screen.dart';
import 'view_note_screen.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  List<Map<String, String>> notes = [];

  void addNote(String title, String content) {
    setState(() {
      notes.add({'title': title, 'content': content});
    });
  }

  void updateNote(int index, String title, String content) {
    setState(() {
      notes[index] = {'title': title, 'content': content};
    });
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset('assets/seaimage1.jpg',fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child:
                  Text('Thinklet',
                      style: GoogleFonts.pirataOne(
                          fontSize: 84, color: Color.fromARGB(223, 49, 66, 95),),),),

                  const SizedBox(height: 8),
                  Center(child:
                  Text(
                    'For quick ideas and \neven quicker notes',
                    style: GoogleFonts.lekton(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),),
                  const SizedBox(height: 50),

                  // Notes list
                  Expanded(
                    child: ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ViewNoteScreen(
                                  title: note['title']!,
                                  content: note['content']!,
                                  onUpdate: (updatedTitle, updatedContent) {
                                    updateNote(index, updatedTitle, updatedContent);
                                  },
                                  onDelete: () {
                                    deleteNote(index);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15,top: 15),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(note['title']!,
                                    style: GoogleFonts.jaldi(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                const SizedBox(height: 4),
                                Text(note['content']!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lekton()),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Add button
          Positioned(
            top: 240,
            right: 180,
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline, size: 38,color:Color.fromARGB(223, 110, 104, 152) ,),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewNoteScreen(addNote: addNote),
                  ),
                );

                // Only refresh UI if a note was added
                if (result != null && result == 'saved') {
                  setState(() {});
                }
               
              },
               
            ),
           
          ),
        ],
      ),
    );
  }
}
