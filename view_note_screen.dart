import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/note_model.dart';

class ViewNoteScreen extends StatefulWidget {
  final int noteIndex;

  const ViewNoteScreen({super.key, required this.noteIndex});

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}


class _ViewNoteScreenState extends State<ViewNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  bool isEditing =false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    _loadNote();
  }

void _loadNote() async {
  final box = await Hive.openBox<NoteModel>('notes');

  if (widget.noteIndex < 0 || widget.noteIndex >= box.length) {
    // Index invalid – go back or show error
    Navigator.pop(context); // or show a message
    return;
  }

  final note = box.getAt(widget.noteIndex);
  setState(() {
    titleController.text = note?.title ?? '';
    contentController.text = note?.content ?? '';
  });
}


void saveNote() async {
  final box = await Hive.openBox<NoteModel>('notes');
  final note = box.getAt(widget.noteIndex);
  if (note != null) {
    note.title = titleController.text.trim();
    note.content = contentController.text.trim();
    await note.save();
  }
  Navigator.pop(context, true); 
}



void deleteNote() async {
  final box = await Hive.openBox<NoteModel>('notes');
  await box.deleteAt(widget.noteIndex);
  Navigator.pop(context, true); 
}


  Widget buildIconButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(223, 110, 104, 152),
        borderRadius: BorderRadius.circular(16),
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
            opacity: 0.2,
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
            'View Note',
            style: GoogleFonts.pirataOne(fontSize: 64),
          ),
        ),
        const SizedBox(height: 20),

        // Content Area
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isEditing
                  ? TextField(
                      controller: titleController,
                      enabled: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF7E9BE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      style: GoogleFonts.lekton(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      titleController.text,
                      style: GoogleFonts.lekton(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
              const SizedBox(height: 16),
              Expanded(
                child: isEditing
                    ? TextField(
                        controller: contentController,
                        enabled: true,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF7E9BE),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        style: GoogleFonts.lekton(),
                      )
                    : SingleChildScrollView(
                        child: Text(
                          contentController.text,
                          style: GoogleFonts.lekton(fontSize: 16),
                        ),
                      ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildIconButton(
              icon: isEditing ? Icons.save : Icons.edit,
              onPressed: () {
                if (isEditing) {
                  saveNote(); // still pops and returns true
                } else {
                  setState(() {
                    isEditing = true;
                  });
                }
              },
            ),
            buildIconButton(
              icon: Icons.delete,
              onPressed: deleteNote,
            ),
          ],
        ),
      ],
    ),
  ),
),

//         SafeArea(
//   child: Padding(
//     padding: const EdgeInsets.all(16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Back button
//         IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new,
//               size: 32, color: Color.fromARGB(223, 110, 104, 152)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         const SizedBox(height: 8),

//         // Title
//         Center(
//           child: Text(
//             'View Note',
//             style: GoogleFonts.pirataOne(fontSize: 64),
//           ),
//         ),
//         const SizedBox(height: 20),

//         // Note content
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               isEditing
//                   ? TextField(
//                       controller: titleController,
//                       enabled: true,
//                       decoration: const InputDecoration(border: InputBorder.none),
//                       style: GoogleFonts.lekton(fontWeight: FontWeight.w900, fontSize: 24),
//                     )
//                   : Text(
//                       titleController.text,
//                       style: GoogleFonts.lekton(fontWeight: FontWeight.w900, fontSize: 24),
//                     ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: isEditing
//                     ? TextField(
//                         controller: contentController,
//                         enabled: true,
//                         expands: true,
//                         maxLines: null,
//                         minLines: null,
//                         decoration: const InputDecoration(border: InputBorder.none),
//                         style: GoogleFonts.lekton(fontSize: 18,fontWeight: FontWeight.w900 ),
//                       )
//                     : SingleChildScrollView(
//                         child: Text(
//                           contentController.text,
//                           style: GoogleFonts.lekton(fontSize: 18,fontWeight: FontWeight.w700,),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 16),

//         // Buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             buildIconButton(
//               icon: isEditing ? Icons.save : Icons.edit,
//               onPressed: () {
//                 if (isEditing) {
//                   saveNote();
//                 } else {
//                   setState(() {
//                     isEditing = true;
//                   });
//                 }
//               },
//             ),
//             buildIconButton(icon: Icons.delete, onPressed: deleteNote),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
        ],
      ),
    );
  }
}
