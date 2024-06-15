class NoteEntity {
  final String id;
  final String title;
  final String? content;

  NoteEntity({
    required this.id,
    required this.title,
    this.content,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content}';
  }
}
