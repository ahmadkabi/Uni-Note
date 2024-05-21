import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final int id;
  final String title;
  final String content;

  NoteModel({
    required this.id,
    required this.title,
    this.content = '',
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
      ];
}
