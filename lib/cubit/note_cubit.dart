import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uninote/db/database_helper.dart';
import '../db/note_entity.dart';
import '../model/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  void getNotes() async {
    try {
      emit(NoteLoading());
      List<NoteEntity> notes = await DatabaseHelper().notes();

      emit(
        NoteSuccess(
          notes
              .map((note) => NoteModel(
                    id: note.id,
                    title: note.title,
                    content: note.content,
                  ))
              .toList(),
        ),
      );
      
    } catch (e) {
      emit(NoteFailed(e.toString()));
    }
  }
  
}