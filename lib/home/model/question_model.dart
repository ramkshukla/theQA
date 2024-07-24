class QuestionModel {
  final String question;
  final String userId;
  QuestionModel({
    required this.question,
    required this.userId,
  });

  factory QuestionModel.initial() => QuestionModel(question: "", userId: "");

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json["question"] ?? "",
      userId: json["userId"] ?? "",
    );
  }

  Map<String, String> toJson() {
    return <String, String>{
      "question": question,
      "userId": userId,
    };
  }
}
