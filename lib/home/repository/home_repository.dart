import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_qa/home/model/question_model.dart';
import 'package:the_qa/home/model/user_model.dart';

abstract class HomeRepository {
  Future<UserModel> getUserData();
  Future<void> savePost({required String questionId, required String question});
  Future<List<QuestionModel>> getQuestions();
  Future<void> postAnswer({
    required String questionId,
    required String question,
    required String userId,
  });
}

class HomeRepositoryImpl extends HomeRepository {
  String userId = Hive.box("userBox").get("userId");

  @override
  Future<UserModel> getUserData() async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DataSnapshot snapshot = await database.ref("users/$userId").get();
    Map<String, dynamic> data =
        Map<String, dynamic>.from(snapshot.value as Map);
    UserModel user = UserModel.fromJson(data);
    return user;
  }

  @override
  Future<void> savePost({
    String? questionId,
    String? question,
  }) async {
    Completer completer = Completer();

    // DatabaseReference ref = FirebaseDatabase.instance
    //     .ref("posts/${FirebaseDatabase.instance.ref().root.push().key}");
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    String? uniqKey = ref.child("Posts").push().key;
    DatabaseReference uRef = ref.child("Posts").child(uniqKey!);

    completer.complete(uRef.set({"userId": userId, "question": question}));

    return completer.future;
  }

  @override
  Future<List<QuestionModel>> getQuestions() async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DataSnapshot snapshot = await database.ref("Posts").get();

    Map<String, dynamic> data =
        Map<String, dynamic>.from(snapshot.value as Map);

    List<QuestionModel> questionsList = data.entries.map((entry) {
      return QuestionModel.fromJson((entry));
    }).toList();

    return questionsList;
  }

  @override
  Future<void> postAnswer({
    required String questionId,
    required String question,
    required String userId,
  }) {
    Completer completer = Completer();

    // DatabaseReference ref = FirebaseDatabase.instance
    //     .ref("posts/${FirebaseDatabase.instance.ref().root.push().key}");
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    String? uniqKey = ref.child("Answers").push().key;
    DatabaseReference uRef = ref.child("Answers").child(uniqKey!);

    completer.complete(
      uRef.set(
        {
          "userId": userId,
          "answer": question,
          "questionId": questionId,
        },
      ),
    );

    return completer.future;
  }
}
