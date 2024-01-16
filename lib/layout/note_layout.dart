import 'package:flutter/material.dart';
import 'package:todoapp/model/data_model.dart';
import 'package:todoapp/services/data_helper.dart';

class NoteScreen extends StatefulWidget {
  final NoteData? note;
  const NoteScreen({this.note, Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController tittleEditingController = TextEditingController();

  final TextEditingController descriptionEditingController =
      TextEditingController();

  final TextEditingController datepicker = TextEditingController();

  Future<void> selectdate() async {
    DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2030));
    if (picked != null) {
      datepicker.text = picked.toString().split(" ")[0];
    }
  }

  void showsnakbar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      tittleEditingController.text = widget.note!.title;
      descriptionEditingController.text = widget.note!.description;
      datepicker.text = widget.note!.dateTime;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: tittleEditingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(15)))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descriptionEditingController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(15)))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              controller: datepicker,
              keyboardType: TextInputType.text,
              onTap: () {
                selectdate();
              },
              decoration: const InputDecoration(
                  filled: true,
                  prefix: Icon(Icons.calendar_month),
                  hintText: "DateTime",
                  hintStyle: TextStyle(fontSize: 18),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(15)))),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  final title = tittleEditingController.text;
                  final description = descriptionEditingController.text;
                  final datatime = datepicker.text;

                  final NoteData model = NoteData(
                      dateTime: datatime,
                      title: title,
                      description: description,
                      id: widget.note?.id);
                  if (widget.note == null) {
                    await DatabaseHelper.insertNote(model);
                    showsnakbar('Note Inserted');
                  } else {
                    await DatabaseHelper.updateNote(model);
                    showsnakbar("Note updated");
                  }
                },
                style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(150, 50))),
                child: Text(
                  widget.note == null ? "Save" : 'Edit',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
