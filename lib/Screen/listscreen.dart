import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todolist/data/firestore.dart';
import 'package:todolist/widget/task_widgets.dart';

import 'home.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

bool show = true;

class _ListscreenState extends State<Listscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: backgroundcolorr(),
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  show = true;
                });
              }
              if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  show = false;
                });
              }
              return true;
            },
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore_Datasource().stream(),
              builder: (context, snapshot) {
                // Loading State
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                // Error State
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading data: ${snapshot.error}'),
                  );
                }

                // No Data State
                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No tasks available.'));
                }

                // Map Firestore documents to note objects
                final noteslist = Firestore_Datasource().getNotes(snapshot);
                print("Notes list updated: ${noteslist.length} items");
                // Display Task Widgets
                return ListView.builder(

                  itemBuilder: (context, index) {
                    final note = noteslist[index];
                    print("Rendering note: ${note.title} - ${note.subtitle}");
                    return Dismissible(key: UniqueKey(),onDismissed: (direction){
                      Firestore_Datasource().deleteNote(note.id);
                    },child: Task_Widgets(note));
                  },
                  itemCount: noteslist.length,
                );
              },
            ),
          ),
        ),
      ),
      appBar: buildAppBar(context),
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            openDialog(context);
          },
          backgroundColor: Colors.black26,
          child: Icon(
            Icons.add,
            size: 34,
            color: Colors.white70,
          ),
          tooltip: 'Add Task',
        ),
      ),
    );
  }
}

Future<void> openDialog(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              )  ,
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
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text.trim();
              String subtitle = subtitleController.text.trim();
              if (title.isNotEmpty && subtitle.isNotEmpty) {
                Firestore_Datasource().AddNote(subtitle, title);
                print('Title: $title');
                print('Subtitle: $subtitle');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Title and Subtitle cannot be empty')),
                );
              }
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}


BoxDecoration backgroundcolorr() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blueGrey, Colors.lightBlueAccent],
    ),
  );
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text("Your list"),
    centerTitle: false,
    actions: [
      IconButton(
        icon: Icon(Icons.account_circle, size: 37, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'profile'),
            ),
          );
        },
      ),
    ],
    backgroundColor: Colors.cyan.shade200,
  );
}
