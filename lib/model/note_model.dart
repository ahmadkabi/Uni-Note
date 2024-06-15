import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String id;
  final String title;
  final String? content;

  NoteModel({
    required this.id,
    required this.title,
    this.content,
  });

  factory NoteModel.fromJson(String id, Map<String, dynamic> json) => NoteModel(
        id: id,
        title: json['title'],
        content: json['content'],
      );

  @override
  List<Object?> get props => [
        id,
        title,
        content,
      ];
}
