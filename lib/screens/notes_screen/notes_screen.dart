import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/notes_screen/widgets/collection_card_widget.dart';
import 'package:masjid_community_29_06_25/screens/notes_screen/widgets/notes_card_widget.dart';
import 'models/notes_model.dart';
import 'notes_view_model.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  void _showAddNoteDialog(BuildContext context, NotesViewModel controller) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String? selectedCollection = 'Default';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 3,
            ),
            DropdownButton<String>(
              value: selectedCollection,
              items: ['Default', 'Work', 'Personal', 'Ideas']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedCollection = newValue;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final note = Note(
                  title: titleController.text,
                  content: contentController.text,
                  createdAt: DateTime.now(),
                  collection: selectedCollection ?? 'Default',
                );
                controller.addNote(note);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditNoteDialog(BuildContext context, NotesViewModel controller, Note note) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);
    String? selectedCollection = note.collection;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 3,
            ),
            DropdownButton<String>(
              value: selectedCollection,
              items: ['Default', 'Work', 'Personal', 'Ideas']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedCollection = newValue;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                note.title = titleController.text;
                note.content = contentController.text;
                note.collection = selectedCollection ?? 'Default';
                controller.updateNote(note);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          Switch(
            value: Get.isDarkMode,
            onChanged: (value) {
              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                // Implement search filtering
              },
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Collections'),
                      Tab(text: 'All Notes'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Collections Tab
                        ListView(
                          children: [
                            CollectionCardWidget(
                              collectionName: 'Default',
                              onTap: () {
                                // Navigate to collection notes
                              },
                            ),
                            CollectionCardWidget(
                              collectionName: 'Work',
                              onTap: () {
                                // Navigate to collection notes
                              },
                            ),
                            CollectionCardWidget(
                              collectionName: 'Personal',
                              onTap: () {
                                // Navigate to collection notes
                              },
                            ),
                            CollectionCardWidget(
                              collectionName: 'Ideas',
                              onTap: () {
                                // Navigate to collection notes
                              },
                            ),
                          ],
                        ),
                        // All Notes Tab
                        Obx(() => ListView.builder(
                          itemCount: controller.notes.length,
                          itemBuilder: (context, index) {
                            final note = controller.notes[index];
                            return NoteCardWidget(
                              note: note,
                              onEdit: () => _showEditNoteDialog(context, controller, note),
                              onDelete: () => controller.deleteNote(note),
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }
}