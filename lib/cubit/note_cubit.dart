import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uninote/db/database_helper.dart';
import '../db/dog.dart';
import '../model/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  void getNotes() async {
    try {
      emit(NoteLoading());
      List<Dog> dogs = await DatabaseHelper().dogs();
      print("kabi4 : $dogs");

      emit(NotesSuccess(List<NoteModel>.filled(
          dogs.length, NoteModel(id: 0, title: "title"))));
    } catch (e) {
      emit(NoteFailed(e.toString()));
    }
  }

  void insertNote({
    required int id,
    required String title,
    String? content,
  }) async {
    try {
      emit(NoteLoading());
      print("kabi1");
      await DatabaseHelper().insertDog(Dog(id: id, name: "", age: 2));
      print("kabi2");

      emit(NoteSuccess2());
    } catch (e) {
      emit(NoteFailed(e.toString()));
    }
  }

}
