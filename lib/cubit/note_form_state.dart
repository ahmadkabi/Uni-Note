part of 'note_form_cubit.dart';

sealed class NoteFormState extends Equatable {
  const NoteFormState();
}

final class NoteFormInitial extends NoteFormState {
  @override
  List<Object> get props => [];
}

class NoteFormLoading extends NoteFormState {
  @override
  List<Object?> get props => [];
}

class NoteFormSuccess extends NoteFormState {
  final NoteModel note;

  const NoteFormSuccess(this.note);

  @override
  List<Object?> get props => [note];
}

class NoteFormUpdateSuccess extends NoteFormState {

  @override
  List<Object?> get props => [];
}

class NoteFormFailed extends NoteFormState {
  final String error;

  const NoteFormFailed(this.error);

  @override
  List<Object?> get props => [error];
}
