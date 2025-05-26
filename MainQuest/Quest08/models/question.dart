class Question {
  final int id;
  final String text;
  final List<String> choices;
  final String answer;

  Question({required this.id, required this.text, required this.choices, required this.answer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
    id: json['id'],
    text: json['text'],
    choices: List<String>.from(json['choices']),
    answer: json['answer'],
    );
  }
}