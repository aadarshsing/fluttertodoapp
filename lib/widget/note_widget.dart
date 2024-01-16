import 'package:flutter/material.dart';
import 'package:todoapp/model/data_model.dart';

class NoteWidget extends StatefulWidget {
  final NoteData noteData;
  final VoidCallback onTap;
  const NoteWidget({required this.noteData, required this.onTap, Key? key})
      : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(7),
          child: ListTile(
            title: Text(
              widget.noteData.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(widget.noteData.description),
            trailing: IconButton(
                onPressed:widget.onTap,
                icon: const Icon(Icons.delete)),
          ),
        ));
  }
}
