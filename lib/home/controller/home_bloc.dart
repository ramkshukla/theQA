import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/home/controller/home_event.dart';
import 'package:the_qa/home/controller/home_state.dart';
import 'package:the_qa/home/model/answer_model.dart';
import 'package:the_qa/home/model/question_model.dart';
import 'package:the_qa/home/repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<GetUserData>(
      (event, emit) async {
        final user = await HomeRepositoryImpl().getUserData();
        emit(state.copyWith(userModel: user));
      },
    );

    on<SavePost>(
      (event, emit) async {
        await HomeRepositoryImpl().savePost(question: event.question);
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
        "Question : ${questions[0].question}".logIt;
        emit(state.copyWith(
            questionModel: questions,
            isLoading: false,
            showAnswer: List.filled(questions.length, false)));
      },
    );

    on<PostAnswer>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        await HomeRepositoryImpl().postAnswer(
          questionId: event.questionId,
          question: event.answer,
          userId: event.userId,
        );
        state.answerController.clear();

        emit(state.copyWith(isLoading: false));
      },
    );

    on<GetAnswer>(
      (event, emit) async {
        emit(state.copyWith(isAnswerLoading: true));
        List<AnswerModel> answers =
            await HomeRepositoryImpl().getAnswers(questionId: event.questionId);
        "Answer List Bloc >>>> $answers".logIt;
        emit(state.copyWith(answerModel: answers, isAnswerLoading: false));
      },
    );
  }
}
