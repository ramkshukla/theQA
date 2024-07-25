abstract class HomeEvent {
  HomeEvent();
}

class GetUserData extends HomeEvent {
  GetUserData();
}

class SavePost extends HomeEvent {
  final String userId;
  final String question;
  SavePost({
    required this.userId,
    required this.question,
  });
}

class SaveQuestion extends HomeEvent {
  final String value;
  SaveQuestion({required this.value});
}

class GetQuestion extends HomeEvent {
  GetQuestion();
}

class PostAnswer extends HomeEvent {
  final String questionId;
  final String question;
  final String userId;
  PostAnswer({
    required this.questionId,
    required this.question,
    required this.userId,
  });
}
