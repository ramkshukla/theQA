class QuestionModel {
  final String questionId;
  final String question;
  final String userId;
  QuestionModel({
    required this.questionId,
    required this.question,
    required this.userId,
  });

  factory QuestionModel.initial() =>
      QuestionModel(questionId: "", question: "", userId: "");

  factory QuestionModel.fromJson(MapEntry<String, dynamic> json) {
    return QuestionModel(
      questionId: json.key,
      question: json.value['question'],
      userId: json.value['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      questionId: <String, dynamic>{
        'question': question,
        'userId': userId,
      },
    };
  }
}