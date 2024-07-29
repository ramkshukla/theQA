class QuestionModel {
  final String questionId;
  final String question;
  final String userId;
  final String userImage;
  final String userName;
  QuestionModel({
    required this.questionId,
    required this.question,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  factory QuestionModel.initial() => QuestionModel(
      questionId: "", question: "", userId: "", userImage: "", userName: "");

  factory QuestionModel.fromJson(MapEntry<String, dynamic> json) {
    return QuestionModel(
        questionId: json.key,
        question: json.value['question'],
        userId: json.value['userId'],
        userImage: json.value['userImage'],
        userName: json.value['userName']);
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
