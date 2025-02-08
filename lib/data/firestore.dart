import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../model/note_model.dart';

class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      print('error=$e');
      return true;
    }
  }

  Future<bool> AddNote(String subtitle, String title) async {
    try {
      var uuid = Uuid().v4();
      Timestamp timestamp = Timestamp.now(); // ✅ Use Firestore Timestamp
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'isDon': false, // Set isDon to false by default'
        'subtitle': subtitle,
        'time': timestamp, // 🔥 Use Timestamp instead of DateTime
        'title': title
      });
      return true;
    } catch (e) {
      print("❌ Firestore AddNote Error: $e");
      return false;
    }
  }


  List<Note> getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data.docs.map<Note>((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['subtitle'],
          (data['time'] as Timestamp).toDate(),
          // Ensure this is correctly casted
          data['title'],
          data['isDon'] ?? false,
        );
      }).toList();
      return notesList;
    } catch (e) {
      print("❌ Error in getNotes(): $e");
      return [];
    }
  }


  Stream<QuerySnapshot> stream() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<bool> isdone(String uuid, bool isDon) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'isDon': isDon});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> updateNote(String id, String subtitle, String title) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(id)
          .update({
        'title': title,
        'subtitle': subtitle,
        // Optional: Update timestamp
      });
      return true;
    } catch (e) {
      print("❌ Error updating note: $e");
      return true;
    }
  }

  Future<bool> deleteNote(String id) async {
    try{
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(id)
          .delete();
          return true;
    }catch(e){
      print("❌ Error deleting note: $e");
      return true;
    }
  }
}
