class AnswerModel {
  final String answerId;
  final String answer;
  final String questionId;
  final String userId;

  AnswerModel({
    required this.questionId,
    required this.answer,
    required this.answerId,
    required this.userId,
  });

  factory AnswerModel.initial() => AnswerModel(
        answer: "",
        answerId: "",
        questionId: "",
        userId: "",
      );

  factory AnswerModel.fromJson(MapEntry<String, dynamic> json) {
    return AnswerModel(
      answerId: json.key,
      answer: json.value["answer"],
      questionId: json.value["questionId"],
      userId: json.value["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      answerId: <String, dynamic>{
        'answer': answer,
        'questionId': questionId,
        'userId': userId,
      },
    };
  }
}
