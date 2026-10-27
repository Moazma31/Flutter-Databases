
import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'models/note.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> _notes = [];

  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final notes = await DatabaseHelper.instance.getNotes();

    if (!mounted) return;

    setState(() {
      _notes = notes;
    });
  }

  Future<void> _deleteNote(int id) async {
    await DatabaseHelper.instance.deleteNote(id);
    await _loadNotes();
  }

  Future<void> _showNoteDialog({Note? note}) async {
    _titleCtrl.text = note?.title ?? '';
    _contentCtrl.text = note?.content ?? '';

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _contentCtrl,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = _titleCtrl.text.trim();
              final content = _contentCtrl.text.trim();

              if (title.isEmpty) return;

              if (note == null) {
                await DatabaseHelper.instance.insertNote(
                  Note(
                    title: title,
                    content: content,
                    createdAt: DateTime.now(),
                  ),
                );
              } else {
                await DatabaseHelper.instance.updateNote(
                  Note(
                    id: note.id,
                    title: title,
                    content: content,
                    createdAt: note.createdAt,
                  ),
                );
              }

              if (ctx.mounted) {
                Navigator.pop(ctx);
              }

              await _loadNotes();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes FA24-BCS-127'),
      ),
      body: _notes.isEmpty
          ? const Center(
        child: Text('No notes yet. Tap + to add one.'),
      )
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, i) {
          final note = _notes[i];

          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            onTap: () => _showNoteDialog(note: note),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteNote(note.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
