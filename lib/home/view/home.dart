import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/_util/string_constants.dart';
import 'package:the_qa/home/controller/home_bloc.dart';
import 'package:the_qa/home/controller/home_event.dart';
import 'package:the_qa/home/controller/home_state.dart';
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
                              "///////Question Id: ${state.questionModel[index].questionId}"
                                  .logIt;
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
                                  return Container(
                                    height: height,
                                    width: width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    child: Column(
                                      children: [
                                        state.answerModel.isEmpty
                                            ? const Center(
                                                child: Text("Not Found"))
                                            : Expanded(
                                                child: ListView.builder(
                                                  itemCount:
                                                      state.answerModel.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text(
                                                      "Answer : ${state.answerModel[index].answer}",
                                                    );
                                                  },
                                                ),
                                              ),
                                        TextFormField(
                                          controller: state.answerController,
                                          decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  context.read<HomeBloc>().add(
                                                        PostAnswer(
                                                          questionId: state
                                                              .questionModel[
                                                                  index]
                                                              .questionId,
                                                          answer: state
                                                              .answerController
                                                              .text,
                                                          userId: state
                                                              .questionModel[
                                                                  index]
                                                              .userId,
                                                        ),
                                                      );
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.send,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                ),
                                              )),
                                        ),
                                        const SizedBox(height: 5)
                                      ],
                                    ),
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
