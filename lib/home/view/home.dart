import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_qa/_util/app_constant.dart';
import 'package:the_qa/_util/routes.dart';
import 'package:the_qa/home/controller/home_bloc.dart';
import 'package:the_qa/home/controller/home_event.dart';
import 'package:the_qa/home/controller/home_state.dart';
import 'package:the_qa/home/view/post_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(GetUserData(userId: ""))
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
        if (state.isAnswerLoading == 2) {
          showCustomBottomSheet(context, state, state.questionId);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0.0,
            surfaceTintColor: Colors.transparent,
            leading: userImage.isNotEmpty
                ? Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: ClipOval(
                          child: Image.network(userImage),
                        ),
                        onPressed: () async {
                          await Hive.box("userBox").clear();
                          userId = "";
                          userImage = "";
                          userName = "";
                          Navigator.popAndPushNamed(context, RouteNames.home);
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  )
                : null,
            automaticallyImplyLeading: false,
            title: Text(
              userName.isNotEmpty ? "Welcome $userName" : "Home",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: userId.isEmpty
                    ? () {
                        Navigator.pushNamed(context, RouteNames.login);
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
                                    }),
                              );
                            });
                        if (result != null &&
                            state.questionController.text.isNotEmpty) {
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
              ? const Center(child: Text("No Questions found"))
              : state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.questionModel.length,
                            itemBuilder: (context, index) {
                              return Container(
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
                                          foregroundImage: NetworkImage(state
                                              .questionModel[index].userImage),
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
                                          key: ValueKey(
                                            state.questionModel[index]
                                                .questionId,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0.0),
                                          onPressed: () {
                                            context.read<HomeBloc>().add(
                                                  GetAnswer(
                                                    userId: state
                                                        .questionModel[index]
                                                        .userId,
                                                    questionId: state
                                                        .questionModel[index]
                                                        .questionId,
                                                    postedTime: DateTime.now()
                                                        .toString(),
                                                    userImage: state
                                                        .questionModel[index]
                                                        .userImage,
                                                    userName: state
                                                        .questionModel[index]
                                                        .userName,
                                                    context: context,
                                                  ),
                                                );
                                          },
                                          child: const Text(
                                            "View Answer",
                                            style: TextStyle(fontSize: 14),
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
                        itemCount: state.answerModel.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      state.answerModel[index].userImage),
                                  foregroundImage: NetworkImage(
                                      state.answerModel[index].userImage),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.answerModel[index].userName),
                                    Text(state.answerModel[index].answer),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  state.answerModel[index].postedTime,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: state.answerController,
                      decoration: InputDecoration(
                        labelText: 'Enter your answer',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: userId.isEmpty
                              ? () {
                                  Navigator.pushNamed(
                                      context, RouteNames.login);
                                }
                              : state.answerController.text.isNotEmpty
                                  ? () {
                                      hcontext.read<HomeBloc>().add(
                                            PostAnswer(
                                              questionId: questionId,
                                              answer:
                                                  state.answerController.text,
                                              userId: userId,
                                              context: bcontext,
                                              postedTime:
                                                  DateTime.now().toString(),
                                              userImage: userImage,
                                              userName: userName,
                                            ),
                                          );
                                    }
                                  : () {},
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
}
