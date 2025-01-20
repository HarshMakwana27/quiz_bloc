class Question {
  final int id;
  final String description;
  final String topic;
  final bool isPublished;
  final List<Option> options;

  Question({
    required this.id,
    required this.description,
    required this.topic,
    required this.isPublished,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      description: json['description'] as String,
      topic: json['topic'] as String,
      isPublished: json['is_published'] as bool,
      options: (json['options'] as List<dynamic>)
          .map((optionJson) => Option.fromJson(optionJson))
          .toList(),
    );
  }
}

class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] as int,
      description: json['description'] as String,
      isCorrect: json['is_correct'] as bool,
    );
  }
}
