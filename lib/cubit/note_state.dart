part of 'note_cubit.dart';

sealed class NoteState extends Equatable {
  const NoteState();
}

final class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteSuccess extends NoteState {
  final List<NoteModel> notes;

  NoteSuccess(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NoteFailed extends NoteState {
  final String error;

  NoteFailed(this.error);

  @override
  List<Object?> get props => [error];
}
