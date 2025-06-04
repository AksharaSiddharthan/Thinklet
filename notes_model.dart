import 'package:hive/hive.dart';

part 'note_model.g.dart'; // This file will be auto-generated

@HiveType(typeId: 0) // Ensure this ID is unique in your app
class NoteModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  NoteModel({required this.title, required this.content});
}
