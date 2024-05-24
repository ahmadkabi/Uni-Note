import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uninote/db/database_helper.dart';
import '../db/note_entity.dart';
import '../model/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  void getNotes() async {
    try {
      emit(NotesLoading());
      List<NoteEntity> notes = await DatabaseHelper().notes();

      emit(
        NotesSuccess(
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
      emit(NotesFailed(e.toString()));
    }
  }
  
}
