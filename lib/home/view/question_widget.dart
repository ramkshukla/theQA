import 'package:flutter/material.dart';
import 'package:the_qa/_util/extension.dart';

class QuestionWidget extends StatefulWidget {
  final String image;
  final String name;
  final String question;
  final Function() postAnswerOnPressed;
  const QuestionWidget({
    super.key,
    required this.image,
    required this.name,
    required this.postAnswerOnPressed,
    required this.question,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool isOpen = false;
  TextEditingController answerController = TextEditingController();
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
                backgroundImage: NetworkImage(widget.image),
                onBackgroundImageError: (exception, stackTrace) {
                  "onBackgroundImageErrorException : $exception".logIt;
                },
                foregroundImage: NetworkImage(widget.image),
                onForegroundImageError: (exception, stackTrace) {
                  "onForegroundImageErrorException : $exception".logIt;
                },
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name.split(" ")[0],
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(widget.question)
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0.0),
                onPressed: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: const Text("Answer"),
              )
            ],
          ),
          Visibility(
            visible: isOpen,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: answerController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: widget.postAnswerOnPressed,
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
