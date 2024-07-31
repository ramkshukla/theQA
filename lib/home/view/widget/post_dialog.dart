import 'package:flutter/material.dart';

class PostDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function() onPressed;
  const PostDialog({
    super.key,
    required this.controller,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.tealAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text("Enter Question!", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              hintText: "Enter question",
              hintStyle: TextStyle(fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                borderSide: BorderSide(color: Colors.blue),
              ),
              filled: true,
              contentPadding: EdgeInsets.only(
                bottom: 10.0,
                left: 10.0,
                right: 10.0,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: onPressed,
                child: const Text("Post"),
              )
            ],
          )
        ],
      ),
    );
  }
}
