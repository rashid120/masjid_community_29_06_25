import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/notes_model.dart';

class NotesViewModel extends GetxController {
  static const String _boxName = 'notesBox';
  final RxList<Note> notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    await Hive.initFlutter();
    final box = await Hive.openBox<Note>(_boxName);
    notes.assignAll(box.values.toList());
    box.listenable().addListener(() {
      notes.assignAll(box.values.toList());
    });
  }

  Future<void> addNote(Note note) async {
    final box = await Hive.openBox<Note>(_boxName);
    await box.add(note);
    notes.add(note);
  }

  Future<void> updateNote(Note note) async {
    final box = await Hive.openBox<Note>(_boxName);
    await note.save();
    notes.refresh();
  }

  Future<void> deleteNote(Note note) async {
    final box = await Hive.openBox<Note>(_boxName);
    await note.delete();
    notes.remove(note);
  }

  Future<void> addCollection(String collectionName) async {
    // This is a simple implementation; in a real app, you might store collections separately
    if (!notes.any((note) => note.collection == collectionName)) {
      final newNote = Note(
        title: 'New Collection',
        content: 'Add notes here...',
        createdAt: DateTime.now(),
        collection: collectionName,
      );
      await addNote(newNote);
    }
  }

  List<Note> getNotesByCollection(String collection) {
    return notes.where((note) => note.collection == collection).toList();
  }
}