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
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.amber[400],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text("Enter Question!"),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              fillColor: Colors.white,
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
