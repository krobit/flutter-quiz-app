class Question {
  final String id;
  final String title;
  Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  @override
  String toString() {
    return 'Question{id: $id, title: $title, options: $options}';
  }
}
