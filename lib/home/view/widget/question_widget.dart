import 'package:flutter/material.dart';
import 'package:the_qa/_util/extension.dart';

class QuestionWidget extends StatelessWidget {
  final String image;
  final String name;
  final String question;
  final Function() answerPressed;
  const QuestionWidget({
    super.key,
    required this.image,
    required this.name,
    required this.answerPressed,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                backgroundImage: NetworkImage(image),
                onBackgroundImageError: (exception, stackTrace) {
                  "onBackgroundImageErrorException : $exception".logIt;
                },
                foregroundImage: NetworkImage(image),
                onForegroundImageError: (exception, stackTrace) {
                  "onForegroundImageErrorException : $exception".logIt;
                },
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.split(" ")[0],
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(question)
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0.0),
                onPressed: answerPressed,
                child:
                    const Text("View Answer", style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
