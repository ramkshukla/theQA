import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/home/controller/home_bloc.dart';
import 'package:the_qa/home/controller/home_event.dart';
import 'package:the_qa/home/controller/home_state.dart';

class AnswerWidget extends StatelessWidget {
  final double height;
  final double width;
  final HomeState state;
  final String quesionId;
  final String userId;
  final BuildContext hcontext;
  const AnswerWidget({
    super.key,
    required this.height,
    required this.width,
    required this.state,
    required this.quesionId,
    required this.userId,
    required this.hcontext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          state.answerModel.isEmpty
              ? const Center(child: Text("Not Found"))
              : Expanded(
                  child: ListView.builder(
                    itemCount: state.answerModel.length,
                    itemBuilder: (context, index) {
                      return Text(
                        "Answer : ${state.answerModel[index].answer}",
                      );
                    },
                  ),
                ),
          state.answerModel.isEmpty ? const Spacer() : const SizedBox(),
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
                  hcontext.read<HomeBloc>().add(
                        PostAnswer(
                          questionId: quesionId,
                          answer: state.answerController.text,
                          userId: userId,
                        ),
                      );
                },
                icon: const Icon(
                  Icons.send,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }
}
