part of 'note_cubit.dart';

sealed class NotesState extends Equatable {
  const NotesState();
}

final class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesLoading extends NotesState {
  @override
  List<Object?> get props => [];
}

class NotesSuccess extends NotesState {
  final List<NoteModel> notes;

  const NotesSuccess(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NotesFailed extends NotesState {
  final String error;

  NotesFailed(this.error);

  @override
  List<Object?> get props => [error];
}
