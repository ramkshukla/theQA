import 'package:flutter/material.dart';

abstract class HomeEvent {
  HomeEvent();
}

class GetUserData extends HomeEvent {
  final String userId;
  GetUserData({required this.userId});
}

class SavePost extends HomeEvent {
  final String userId;
  final String question;
  final String userName;
  final String userImage;
  SavePost({
    required this.userId,
    required this.question,
    required this.userName,
    required this.userImage,
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
  final String answer;
  final String userId;
  final String postedTime;
  final String userImage;
  final String userName;
  final BuildContext context;
  PostAnswer({
    required this.questionId,
    required this.answer,
    required this.userId,
    required this.context,
    required this.userImage,
    required this.userName,
    required this.postedTime,
  });
}

class GetAnswer extends HomeEvent {
  final String questionId;
  final BuildContext context;
  final String userId;
  final String postedTime;
  final String userImage;
  final String userName;
  GetAnswer({
    required this.questionId,
    required this.context,
    required this.userId,
    required this.userImage,
    required this.userName,
    required this.postedTime,
  });
}
