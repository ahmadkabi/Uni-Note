import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uninote/model/note_model.dart';

class NoteService {
  final CollectionReference _noteRef =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(NoteModel note) async {
    try {
      _noteRef.doc(note.id.toString()).set({
        'title': note.title,
        'content': note.content,
      });
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

  Future<void> deleteNote(NoteModel note) async {
    try {
      _noteRef.doc(note.id.toString()).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<List<NoteModel>> getNotes() async {
    try {
      QuerySnapshot result = await _noteRef.get();

      List<NoteModel> notes = result.docs
          .map((e) => NoteModel.fromJson(
                int.parse(e.id),
                e.data() as Map<String, dynamic>,
              ))
          .toList();

      return notes;
    } catch (e) {
      throw e;
    }
  }

}
