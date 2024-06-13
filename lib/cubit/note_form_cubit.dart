import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uninote/db/database_helper.dart';
import 'package:uninote/service/note_service.dart';
import '../entity/note_entity.dart';
import '../model/note_model.dart';

part 'note_form_state.dart';

class NoteFormCubit extends Cubit<NoteFormState> {
  NoteFormCubit() : super(NoteFormInitial());

  void getNoteById(int? id) async {
    try {
      if (id == null) {
        emit(NoteFormInitial());
      } else {
        emit(NoteFormLoading());
        NoteEntity? note = await DatabaseHelper().getNoteById(id);

        if (note == null) {
          emit(NoteFormInitial());
        } else {
          emit(
            NoteFormSuccess(NoteModel(
              id: note.id,
              title: note.title,
              content: note.content,
            )),
          );
        }
      }
    } catch (e) {
      emit(NoteFormFailed(e.toString()));
    }
  }

  void insertNote({
    int? id,
    required String title,
    String? content,
  }) async {
    try {
      emit(NoteFormLoading());

      await NoteService().addNote(
        NoteModel(id: id, title: title, content: content),
      );

      await DatabaseHelper().insertNote(
        NoteEntity(id: id, title: title, content: content),
      );

      emit(NoteFormUpdateSuccess());
    } catch (e) {
      emit(NoteFormFailed(e.toString()));
    }
  }

  void updateNote({
    required int id,
    required String title,
    String? content,
  }) async {
    try {
      emit(NoteFormLoading());

      await NoteService().updateNote(
        NoteModel(id: id, title: title, content: content),
      );

      await DatabaseHelper().updateNote(
        NoteEntity(id: id, title: title, content: content),
      );

      emit(NoteFormUpdateSuccess());
    } catch (e) {
      emit(NoteFormFailed(e.toString()));
    }
  }

  void deleteNote({
    required int id,
  }) async {
    try {
      emit(NoteFormLoading());

      await NoteService().deleteNote(id.toString());

      await DatabaseHelper().deleteNote(id);

      emit(NoteFormUpdateSuccess());
    } catch (e) {
      emit(NoteFormFailed(e.toString()));
    }
  }
}
