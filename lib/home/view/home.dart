import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/app_constant.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/_util/string_constants.dart';
import 'package:the_qa/google_auth/view/google_auth.dart';
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
        ..add(GetUserData(userId: userId))
        ..add(GetQuestion()),
      child: const HomeUI(),
    );
  }
}

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (!state.isAnswerLoading) {
          showCustomBottomSheet(context, state, state.userId, state.questionId);
        }
      },
      builder: (context, state) {
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
                onPressed: userId.isEmpty
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const GoogleAuth();
                            },
                          ),
                        );
                      }
                    : () async {
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
                                  userId: userId,
                                  userImage: state.userModel.imgUrl,
                                  userName: state.userModel.name,
                                  question: result["text"],
                                ),
                              );
                        }
                      },
                icon: const Icon(Icons.post_add),
              )
            ],
          ),
          body: state.questionModel.isEmpty
              ? const Center(
                  child: Text("No Questions found"),
                )
              : state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.questionModel.length,
                            itemBuilder: (context, index) {
                              return Container(
                                key: ValueKey(
                                    state.questionModel[index].questionId),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  border: Border.all(color: Colors.blueAccent),
                                  color: Colors.tealAccent,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          backgroundImage: NetworkImage(state
                                              .questionModel[index].userImage),
                                          onBackgroundImageError:
                                              (exception, stackTrace) {
                                            "onBackgroundImageErrorException : $exception"
                                                .logIt;
                                          },
                                          foregroundImage: NetworkImage(
                                              state.userModel.imgUrl),
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
                                              state
                                                  .questionModel[index].userName
                                                  .split(" ")[0],
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(state
                                                .questionModel[index].question)
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          key: ValueKey(state
                                              .questionModel[index].questionId),
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0.0),
                                          onPressed: userId.isEmpty
                                              ? () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return const GoogleAuth();
                                                      },
                                                    ),
                                                  );
                                                }
                                              : () {
                                                  context.read<HomeBloc>().add(
                                                        GetAnswer(
                                                          userId: state
                                                              .questionModel[
                                                                  index]
                                                              .userId,
                                                          questionId: state
                                                              .questionModel[
                                                                  index]
                                                              .questionId,
                                                          context: context,
                                                        ),
                                                      );
                                                  // if (!context
                                                  //     .read<HomeBloc>()
                                                  //     .state
                                                  //     .isAnswerLoading) {
                                                  //   showCustomBottomSheet(
                                                  //     context,
                                                  //     context.read<HomeBloc>().state,
                                                  //     context
                                                  //         .read<HomeBloc>()
                                                  //         .state
                                                  //         .questionModel[index]
                                                  //         .questionId,
                                                  //     context
                                                  //         .read<HomeBloc>()
                                                  //         .state
                                                  //         .questionModel[index]
                                                  //         .userId,
                                                  //   );
                                                  // }
                                                  // context.read<HomeBloc>().stream.listen(
                                                  //   (newState) {
                                                  //     if (!state.isAnswerLoading &&
                                                  //         state.answerModel.isNotEmpty) {
                                                  //       showCustomBottomSheet(
                                                  //         context,
                                                  //         newState,
                                                  //         newState.questionModel[index]
                                                  //             .questionId,
                                                  //         newState.questionModel[index]
                                                  //             .userId,
                                                  //       );
                                                  //     }
                                                  //   },
                                                  // )
                                                },
                                          child: const Text(
                                            "View Answer",
                                            style: TextStyle(fontSize: 16),
                                          ),
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
  String userId,
  String questionId,
) async {
  showModalBottomSheet(
    context: hcontext,
    isScrollControlled: true,
    builder: (bcontext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(bcontext).viewInsets.bottom,
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
                        labelText: 'Enter your answer',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            hcontext.read<HomeBloc>().add(
                                  PostAnswer(
                                    questionId: questionId,
                                    answer: state.answerController.text,
                                    userId: userId,
                                    context: bcontext,
                                  ),
                                );
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );

  // // Listen to state changes and show the bottom sheet when answers are loaded
  // final homeBloc = hcontext.read<HomeBloc>();
  // final subscription = homeBloc.stream.listen((newState) {
  //   ">>>>Called".logIt;
  //   if (!newState.isAnswerLoading) {
  //     showModalBottomSheet(
  //       context: hcontext,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //             bottom: MediaQuery.of(context).viewInsets.bottom,
  //           ),
  //           child: Container(
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //             ),
  //             child: DraggableScrollableSheet(
  //               initialChildSize: 0.5,
  //               minChildSize: 0.25,
  //               maxChildSize: 0.9,
  //               controller: DraggableScrollableController(),
  //               expand: false,
  //               builder: (context, scrollController) {
  //                 if (newState.answerModel.isEmpty) {
  //                   return const Center(child: Text('No answers available'));
  //                 } else {
  //                   return Padding(
  //                     padding: const EdgeInsets.all(16.0),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Expanded(
  //                           child: ListView.builder(
  //                             key: UniqueKey(),
  //                             itemCount: newState.answerModel.length,
  //                             itemBuilder: (context, index) {
  //                               return Text(
  //                                 key: ValueKey(
  //                                     newState.answerModel[index].answerId),
  //                                 newState.answerModel[index].answer,
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                         const SizedBox(height: 20),
  //                         TextFormField(
  //                           controller: newState.answerController,
  //                           decoration: InputDecoration(
  //                             labelText: 'Enter your answer',
  //                             border: const OutlineInputBorder(),
  //                             suffixIcon: IconButton(
  //                               onPressed: () {
  //                                 hcontext.read<HomeBloc>().add(
  //                                       PostAnswer(
  //                                         questionId: questionId,
  //                                         answer:
  //                                             newState.answerController.text,
  //                                         userId: userId,
  //                                       ),
  //                                     );
  //                                 Navigator.of(context).pop();
  //                               },
  //                               icon: const Icon(Icons.send),
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(height: 10),
  //                       ],
  //                     ),
  //                   );
  //                 }
  //               },
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // });

  // await Future.delayed(Duration.zero);
  // subscription.cancel();
}
