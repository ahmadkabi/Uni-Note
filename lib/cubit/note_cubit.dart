import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uninote/db/database_helper.dart';
import '../entity/note_entity.dart';
import '../model/note_model.dart';
import '../service/note_service.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  void getNotes() async {
    try {
      emit(NotesLoading());

      List<NoteModel> notesModels = await NoteService().getNotes();

      DatabaseHelper dbHelper = DatabaseHelper();

      await dbHelper.insertNotes(notesModels
          .map((e) => NoteEntity(
                id: e.id,
                title: e.title,
                content: e.content,
              ))
          .toList());

      List<NoteEntity> notes = await dbHelper.getNotes();

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
