import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/Auth/main_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,required this.title} );
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _selectedStars = 0;

  // Logout Function
  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const mainpage()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // To-Do History Stream
  Stream<QuerySnapshot> getTodoHistory() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('notes')
        .orderBy('time', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.cyan.shade200,
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text("No User Logged In");
                        }
                        return Column(
                          children: [
                            Text(
                              snapshot.data!.displayName ?? "User",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(snapshot.data!.email ?? "No Email"),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // To-Do History Section
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your To-Do History",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getTodoHistory(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          var notes = snapshot.data!.docs;
                          if (notes.isEmpty) {
                            return const Center(child: Text("No tasks found."));
                          }
                          return ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              var note = notes[index].data() as Map<String, dynamic>;
                              return ListTile(
                                title: Text(note['title']),
                                subtitle: Text(note['subtitle']),
                                trailing: Icon(
                                  note['isDon'] ? Icons.check_circle : Icons.pending,
                                  color: note['isDon'] ? Colors.green : Colors.orange,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Rate Us Section
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Rate Us",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _selectedStars ? Icons.star : Icons.star_border,
                            color: Colors.orange,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedStars = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // About Us Section
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "This To-Do app helps users manage their daily tasks efficiently. "
                          "You can add, edit, and track your tasks with ease.",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
