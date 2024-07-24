import 'package:flutter/material.dart';
import 'package:the_qa/home/model/question_model.dart';
import 'package:the_qa/home/model/user_model.dart';

class HomeState {
  final bool isLoading;
  final String question;
  final List<QuestionModel> questionModel;
  final UserModel userModel;
  TextEditingController controller = TextEditingController();
  HomeState({
    required this.isLoading,
    required this.userModel,
    required this.controller,
    required this.question,
    required this.questionModel,
  });

  factory HomeState.initial() => HomeState(
        isLoading: false,
        question: "",
        questionModel: [],
        userModel: UserModel.initial(),
        controller: TextEditingController(),
      );

  HomeState copyWith({
    bool? isLoading,
    String? question,
    UserModel? userModel,
    List<QuestionModel>? questionModel,
    TextEditingController? controller,
  }) {
    return HomeState(
      question: question ?? this.question,
      questionModel: questionModel ?? this.questionModel,
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
      controller: controller ?? this.controller,
    );
  }
}
