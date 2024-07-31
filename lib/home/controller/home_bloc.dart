import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_qa/_util/app_constant.dart';
import 'package:the_qa/_util/extension.dart';
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
        userName = await Hive.box("userBox").get("userName", defaultValue: "");
        userImage =
            await Hive.box("userBox").get("userImage", defaultValue: "");
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
        state.questionController.clear();
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
        "Images : ${questions[0].userImage}".logIt;
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
          postedTime: event.postedTime,
          userImage: event.userImage,
          userName: event.userName,
          userId: event.userId,
        );
        state.answerController.clear();
        // ignore: use_build_context_synchronously
        Navigator.of(event.context).pop();
      },
    );

    on<GetAnswer>(
      (event, emit) async {
        emit(state.copyWith(isAnswerLoading: 1, answerModel: []));
        List<AnswerModel> answers =
            await HomeRepositoryImpl().getAnswers(questionId: event.questionId);

        emit(
          state.copyWith(
            answerModel: answers,
            isAnswerLoading: 2,
            userId: event.userId,
            questionId: event.questionId,
          ),
        );
      },
    );
  }
}
