class Note {
  String title;
  String content;
  List<String> categories;
  DateTime dateCreated;

  Note({
    required this.title,
    required this.content,
    required this.categories,
  }) : dateCreated = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'categories': categories,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] ?? '', // Default to empty string if null
      content: json['content'] ?? '', // Default to empty string if null
      categories: List<String>.from(json['categories'] ?? []), // Default to empty list if null
    )..dateCreated = DateTime.tryParse(json['dateCreated'] ?? '') ?? DateTime.now(); // Use current time if parsing fails
  }
}
