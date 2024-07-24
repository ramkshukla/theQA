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
