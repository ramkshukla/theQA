class AnswerModel {
  final String questionId;
  final String question;
  final String userId;
  AnswerModel({
    required this.questionId,
    required this.question,
    required this.userId,
  });

  factory AnswerModel.initial() =>
      AnswerModel(questionId: "", question: "", userId: "");

  factory AnswerModel.fromJson(MapEntry<String, dynamic> json) {
    return AnswerModel(
      questionId: json.key,
      question: json.value["question"],
      userId: json.value["userId"],
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
