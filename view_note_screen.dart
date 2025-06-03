import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewNoteScreen extends StatefulWidget {
  final String title;
  final String content;
  final Function(String, String) onUpdate;
  final Function() onDelete;

  const ViewNoteScreen({
    super.key,
    required this.title,
    required this.content,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
  }

  void saveEdits() {
    widget.onUpdate(titleController.text.trim(), contentController.text.trim());
    setState(() {
      isEditing = false;
    });
  }

  void deleteNote() {
    widget.onDelete();
    Navigator.pop(context);
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
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 32,
                      color: Color.fromARGB(223, 110, 104, 152),
                    ),
                  ),
                  Center(
                    child: Text(
                      "View Note",
                      style: GoogleFonts.pirataOne(fontSize: 64),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title Field
                  TextField(
                    controller: titleController,
                    enabled: isEditing,
                    style: GoogleFonts.lekton(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: GoogleFonts.lekton(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Content Field Container
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: contentController,
                        enabled: isEditing,
                        maxLines: null,
                        expands: true,
                        style: GoogleFonts.lekton(fontSize: 16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  // Spacer to prevent overlap with icons
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),

          // Icon row at bottom
          Positioned(
            bottom: 12,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Edit button
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(223, 110, 104, 152),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    iconSize: 28,
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                  ),
                ),

                // Save button
                if (isEditing)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(223, 110, 104, 152),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      icon: const Icon(Icons.save, color: Colors.white),
                      iconSize: 20,
                      onPressed: saveEdits,
                    ),
                  ),

                // Delete button
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(223, 110, 104, 152),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    // iconSize: 28,
                    onPressed: deleteNote,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
