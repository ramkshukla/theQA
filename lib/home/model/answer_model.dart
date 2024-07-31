class AnswerModel {
  final String answerId;
  final String answer;
  final String questionId;
  final String userId;
  final String userImage;
  final String postedTime;
  final String userName;

  AnswerModel({
    required this.questionId,
    required this.answer,
    required this.answerId,
    required this.userId,
    required this.userImage,
    required this.userName,
    required this.postedTime,
  });

  factory AnswerModel.initial() => AnswerModel(
      answer: "",
      answerId: "",
      questionId: "",
      userId: "",
      postedTime: "",
      userImage: "",
      userName: "");

  factory AnswerModel.fromJson(MapEntry<String, dynamic> json) {
    return AnswerModel(
        answerId: json.key,
        answer: json.value["answer"],
        questionId: json.value["questionId"],
        userId: json.value["userId"],
        postedTime: json.value["postedTime"],
        userImage: json.value["userImage"],
        userName: json.value["userName"]);
  }

  Map<String, dynamic> toJson() {
    return {
      answerId: <String, dynamic>{
        'answer': answer,
        'questionId': questionId,
        'userId': userId,
        'postedTime': postedTime,
        'userImage': userImage,
        'userName': userName,
      },
    };
  }
}
