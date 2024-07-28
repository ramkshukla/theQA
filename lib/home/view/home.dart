import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/_util/string_constants.dart';
import 'package:the_qa/home/controller/home_bloc.dart';
import 'package:the_qa/home/controller/home_event.dart';
import 'package:the_qa/home/controller/home_state.dart';
import 'package:the_qa/home/view/widget/post_dialog.dart';

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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        "State Answer Loading : ${state.isAnswerLoading}".logIt;
        return Scaffold(
          resizeToAvoidBottomInset: true,
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
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        key: GlobalKey(),
                        itemCount: state.questionModel.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Colors.blueAccent),
                              color: Colors.tealAccent,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage:
                                          NetworkImage(state.userModel.imgUrl),
                                      onBackgroundImageError:
                                          (exception, stackTrace) {
                                        "onBackgroundImageErrorException : $exception"
                                            .logIt;
                                      },
                                      foregroundImage:
                                          NetworkImage(state.userModel.imgUrl),
                                      onForegroundImageError:
                                          (exception, stackTrace) {
                                        "onForegroundImageErrorException : $exception"
                                            .logIt;
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.userModel.name.split(" ")[0],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                            state.questionModel[index].question)
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0.0),
                                      onPressed: () {
                                        "Question Id : ${state.questionModel[index].question}"
                                            .logIt;
                                        showCustomBottomSheet(
                                          context,
                                          state,
                                          state.questionModel[index].questionId,
                                          state.questionModel[index].userId,
                                        );
                                      },
                                      child: const Text("View Answer",
                                          style: TextStyle(fontSize: 16)),
                                    )
                                  ],
                                ),
                              ],
                            ),
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

Future<void> showCustomBottomSheet(
  BuildContext hcontext,
  HomeState state,
  String questionId,
  String userId,
) async {
  showModalBottomSheet(
    context: hcontext,
    isScrollControlled: true,
    builder: (context) {
      hcontext
          .read<HomeBloc>()
          .add(GetAnswer(questionId: questionId, context: context));
      Future.delayed(const Duration(seconds: 1));
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 0.9,
            controller: DraggableScrollableController(),
            expand: false,
            builder: (context, scrollController) {
              if (state.isAnswerLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.answerModel.isEmpty) {
                return const Center(child: Text('No answers available'));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          key: UniqueKey(),
                          itemCount: state.answerModel.length,
                          itemBuilder: (context, index) {
                            "Answer Length : ${state.answerModel.length}".logIt;
                            "Answer : ${state.answerModel[index].answer}".logIt;
                            return Text(
                              key: ValueKey(state.answerModel[index].answerId),
                              state.answerModel[index].answer,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Spacer(),
                      TextFormField(
                        controller: state.answerController,
                        decoration: InputDecoration(
                          labelText: 'Enter your question',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              hcontext.read<HomeBloc>().add(
                                    PostAnswer(
                                      questionId: questionId,
                                      answer: state.answerController.text,
                                      userId: userId,
                                    ),
                                  );
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      );
    },
  );
}
