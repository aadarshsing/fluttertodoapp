import 'package:flutter/material.dart';
import 'package:todoapp/layout/note_layout.dart';
import 'package:todoapp/model/data_model.dart';
import 'package:todoapp/services/data_helper.dart';
import 'package:todoapp/widget/note_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo app"),
      ),
      body: FutureBuilder<List<NoteData>?>(
          future: DatabaseHelper.getAllNote(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data;
                    final noteData = data![index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NoteScreen(
                                    note: noteData,
                                  )));
                          setState(() {});
                        },
                        child: NoteWidget(
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    icon: const Icon(Icons.delete),
                                    title: const Text("Delete Note"),
                                    content: const Text(
                                        "Are you sure want to delete note?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            DatabaseHelper.deleteNote(noteData);
                                            Navigator.of(context).pop();
                                            setState(() {});
                                          },
                                          child: const Text("Yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("No"))
                                    ],
                                  );
                                });
                          },
                          noteData: noteData,
                        ));
                  },
                );
              }
            }
            return const Center(child: Text("nothing in note"));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NoteScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
