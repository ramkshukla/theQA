import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/_util/string_constants.dart';
import 'package:the_qa/home/controller/home_bloc.dart';
import 'package:the_qa/home/controller/home_event.dart';
import 'package:the_qa/home/controller/home_state.dart';
import 'package:the_qa/home/view/answer_widget.dart';
import 'package:the_qa/home/view/post_dialog.dart';
import 'package:the_qa/home/view/question_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(GetUserData())
        ..add(GetQuestion()),
      child: const HomeUI(),
    );
  }
}

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    final BuildContext hcontext = context;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              HomeConstants.home,
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  final result = await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: PostDialog(
                            controller: state.questionController,
                            onPressed: () {
                              Navigator.of(context).pop(
                                {"text": state.questionController.text},
                              );
                            },
                          ),
                        );
                      });
                  if (result != null) {
                    context.read<HomeBloc>().add(
                          SavePost(
                            userId: state.userModel.uid,
                            question: result["text"],
                          ),
                        );
                  }
                },
                icon: const Icon(Icons.post_add),
              )
            ],
          ),
          body: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.questionModel.length,
                        itemBuilder: (context, index) {
                          return QuestionWidget(
                            image: state.userModel.imgUrl,
                            answerPressed: () async {
                              context.read<HomeBloc>().add(
                                    GetAnswer(
                                      questionId:
                                          state.questionModel[index].questionId,
                                      context: context,
                                    ),
                                  );
                              await showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return AnswerWidget(
                                    height: height,
                                    width: width,
                                    state: state,
                                    quesionId:
                                        state.questionModel[index].questionId,
                                    userId: state.questionModel[index].userId,
                                    hcontext: hcontext,
                                  );
                                },
                              );
                            },
                            name: state.userModel.name,
                            question: state.questionModel[index].question,
                          );
                        },
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
