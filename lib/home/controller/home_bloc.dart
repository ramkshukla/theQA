import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_qa/_util/app_constant.dart';
import 'package:the_qa/home/controller/home_event.dart';
import 'package:the_qa/home/controller/home_state.dart';
import 'package:the_qa/home/model/answer_model.dart';
import 'package:the_qa/home/model/question_model.dart';
import 'package:the_qa/home/model/user_model.dart';
import 'package:the_qa/home/repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<GetUserData>(
      (event, emit) async {
        userId = await Hive.box("userBox").get("userId", defaultValue: "");
        UserModel user = await HomeRepositoryImpl().getUserData(userId: userId);
        emit(state.copyWith(userModel: user));
      },
    );

    on<SavePost>(
      (event, emit) async {
        await HomeRepositoryImpl().savePost(
          question: event.question,
          userId: event.userId,
          userImage: event.userImage,
          userName: event.userName,
        );
        add(GetQuestion());
      },
    );

    on<SaveQuestion>(
      (event, emit) {
        emit(state.copyWith(question: event.value));
      },
    );

    on<GetQuestion>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        List<QuestionModel> questions =
            await HomeRepositoryImpl().getQuestions();
        // add(GetUserData(userId: userId));
        emit(
          state.copyWith(
            questionModel: questions,
            isLoading: false,
            showAnswer: List.filled(questions.length, false),
          ),
        );
      },
    );

    on<PostAnswer>(
      (event, emit) async {
        await HomeRepositoryImpl().postAnswer(
          questionId: event.questionId,
          question: event.answer,
          userId: event.userId,
        );
        state.answerController.clear();
        Navigator.of(event.context).pop();
      },
    );

    on<GetAnswer>(
      (event, emit) async {
        emit(state.copyWith(isAnswerLoading: true, answerModel: []));
        List<AnswerModel> answers =
            await HomeRepositoryImpl().getAnswers(questionId: event.questionId);
        emit(
          state.copyWith(
              answerModel: answers,
              isAnswerLoading: false,
              userId: event.userId,
              questionId: event.questionId),
        );
      },
    );
  }
}
