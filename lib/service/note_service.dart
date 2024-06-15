import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uninote/model/note_model.dart';

class NoteService {
  final CollectionReference _noteRef =
      FirebaseFirestore.instance.collection('notes');

  Future<String> addNote(
      String title,
      String? content,
      ) async {
    try {
      DocumentReference docRef = await _noteRef.add({
        'title': title,
        'content': content,
      });

      return docRef.id;

    } catch (e) {
      throw e;
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      _noteRef.doc(note.id.toString()).update({
        'title': note.title,
        'content': note.content,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      _noteRef.doc(id).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<List<NoteModel>> getNotes() async {
    try {
      QuerySnapshot result = await _noteRef.get();

      List<NoteModel> notes = result.docs
          .map((e) => NoteModel.fromJson(
                e.id,
                e.data() as Map<String, dynamic>,
              ))
          .toList();

      return notes;
    } catch (e) {
      throw e;
    }
  }

}
