import 'package:flutter/material.dart';
import 'package:the_qa/home/model/answer_model.dart';
import 'package:the_qa/home/model/question_model.dart';
import 'package:the_qa/home/model/user_model.dart';

class HomeState {
  final bool isLoading;
  final String question;
  final List<QuestionModel> questionModel;
  final List<AnswerModel> answerModel;
  final UserModel userModel;
  final List<bool> showAnswer;
  final String userId;
  final String questionId;
  final bool isShowing;
  final int isAnswerLoading;
  final String userImage;
  final String userName;
  final String postedTime;
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  HomeState({
    required this.questionId,
    required this.userId,
    required this.showAnswer,
    required this.isAnswerLoading,
    required this.isShowing,
    required this.isLoading,
    required this.userModel,
    required this.questionController,
    required this.question,
    required this.answerModel,
    required this.answerController,
    required this.postedTime,
    required this.questionModel,
    required this.userImage,
    required this.userName,
  });

  factory HomeState.initial() => HomeState(
      isLoading: false,
      isShowing: false,
      showAnswer: [],
      isAnswerLoading: 0,
      questionId: "",
      userId: "",
      question: "",
      questionModel: [],
      answerModel: [],
      userModel: UserModel.initial(),
      questionController: TextEditingController(),
      answerController: TextEditingController(),
      postedTime: "",
      userImage: "",
      userName: "");

  HomeState copyWith(
      {bool? isLoading,
      String? question,
      bool? isShowing,
      int? isAnswerLoading,
      List<bool>? showAnswer,
      UserModel? userModel,
      String? userId,
      String? questionId,
      List<AnswerModel>? answerModel,
      List<QuestionModel>? questionModel,
      TextEditingController? questionController,
      TextEditingController? answerController,
      String? userImage,
      String? userName,
      String? postedTime}) {
    return HomeState(
      questionId: questionId ?? this.questionId,
      userId: userId ?? this.userId,
      isAnswerLoading: isAnswerLoading ?? this.isAnswerLoading,
      showAnswer: showAnswer ?? this.showAnswer,
      isShowing: isShowing ?? this.isShowing,
      answerController: answerController ?? this.answerController,
      question: question ?? this.question,
      answerModel: answerModel ?? this.answerModel,
      questionModel: questionModel ?? this.questionModel,
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
      questionController: questionController ?? this.questionController,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
      postedTime: postedTime ?? this.postedTime,
    );
  }
}
