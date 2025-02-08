import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Screen/home.dart';
import 'package:todolist/Screen/listscreen.dart';
import 'package:todolist/const/color.dart';
import 'package:todolist/data/firestore.dart';

import '../model/note_model.dart';

import 'package:flutter/material.dart';
import '../model/note_model.dart';

class Task_Widgets extends StatefulWidget {
  final Note _note;

  const Task_Widgets(this._note, {super.key});

  @override
  State<Task_Widgets> createState() => _Task_WidgetsState();
}

bool isChecked = false;

class _Task_WidgetsState extends State<Task_Widgets> {

  @override
  Widget build(BuildContext context) {
    bool isDone= widget._note.isDon;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Image Container
                Container(
                  height: 130,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    image: DecorationImage(
                        image: AssetImage('images/2q.png'),
                        fit: BoxFit.cover), // Replace with your image
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Display Note data with Text widgets
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Title Text
                            SizedBox(
                              width: 100,
                              child: Text(
                                widget._note.title, // Note's title
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade200,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Checkbox
                            Checkbox(
                              value: isDone,
                              onChanged: (value) {

                                setState(() {
                                  isDone=!isDone;
                                });
                                Firestore_Datasource().isdone(widget._note.id,isDone);
                              },
                            ),
                          ],
                        ),
                      ),
                      // Subtitle Text
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: SizedBox(
                          width: 155,
                          child: Text(
                            widget._note.subtitle, // Note's subtitle
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // Buttons
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Time selection logic
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow),
                            child: Row(
                              children: [
                                Icon(Icons.timelapse),
                                Text(
                                  DateFormat(' HH:mm').format(widget._note.time),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 2.3),
                          ElevatedButton(
                            onPressed: () {
                              openDialog(context,note: widget._note);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade100),
                            child: Text('EDIT'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future<void> openDialog(BuildContext context, {Note? note}) {
  TextEditingController titleController = TextEditingController(text: note?.title ?? "");
  TextEditingController subtitleController = TextEditingController(text: note?.subtitle ?? "");

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(note == null ? 'Add Task' : 'Edit Task'), // Dynamically update title
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                labelText: 'Subtitle',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              String title = titleController.text.trim();
              String subtitle = subtitleController.text.trim();

              if (title.isNotEmpty && subtitle.isNotEmpty) {
                if (note == null) {
                  // Adding a new note
                  await Firestore_Datasource().AddNote(subtitle, title);
                } else {
                  // Updating an existing note
                  await Firestore_Datasource().updateNote(note.id, subtitle, title);
                }
                print('Title: $title');
                print('Subtitle: $subtitle');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Title and Subtitle cannot be empty')),
                );
              }
              Navigator.of(context).pop();
            },
            child: Text(note == null ? 'Submit' : 'Update'),
          ),
        ],
      );
    },
  );
}
