import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/home/model/answer_model.dart';
import 'package:the_qa/home/model/question_model.dart';
import 'package:the_qa/home/model/user_model.dart';

abstract class HomeRepository {
  Future<UserModel> getUserData({required String userId});
  Future<void> savePost({
    required String question,
    required String userId,
    required String userName,
    required String userImage,
  });
  Future<List<QuestionModel>> getQuestions();
  Future<void> postAnswer({
    required String questionId,
    required String question,
    required String userId,
    required String userName,
    required String userImage,
    required String postedTime,
  });
  Future<List<AnswerModel>> getAnswers({required String questionId});
}

class HomeRepositoryImpl extends HomeRepository {
  // String userId = Hive.box("userBox").get("userId");

  @override
  Future<UserModel> getUserData({String? userId}) async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DataSnapshot snapshot = await database.ref("users/$userId").get();
    Map<String, dynamic> data =
        Map<String, dynamic>.from(snapshot.value as Map);
    UserModel user = UserModel.fromJson(data);
    return user;
  }

  @override
  Future<void> savePost(
      {String? question,
      String? userId,
      String? userName,
      String? userImage}) async {
    Completer completer = Completer();
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    String? uniqKey = ref.child("Posts").push().key;
    DatabaseReference uRef = ref.child("Posts").child(uniqKey!);
    completer.complete(uRef.set({
      "userId": userId,
      "userName": userName,
      "userImage": userImage,
      "question": question,
    }));
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
    required String userImage,
    required String userName,
    required String postedTime,
  }) {
    Completer completer = Completer();
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    String? uniqKey = ref.child("Answers").push().key;
    DatabaseReference uRef = ref.child("Answers").child(uniqKey!);

    completer.complete(
      uRef.set(
        {
          "userId": userId,
          "answer": question,
          "postedTime": postedTime,
          "userImage": userImage,
          "userName": userName,
          "questionId": questionId,
        },
      ),
    );

    return completer.future;
  }

  @override
  Future<List<AnswerModel>> getAnswers({required String questionId}) async {
    ">>>>>>>Question : $questionId".logIt;
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference reference = database.ref("Answers");
    Query query = reference.orderByChild('questionId').equalTo(questionId);
    DatabaseEvent event = await query.once();
    if (event.snapshot.value == null) {
      return [];
    }

    ">>>>Value : ${event.snapshot.value}".logIt;

    Map<String, dynamic> data =
        Map<String, dynamic>.from(event.snapshot.value as Map);

    List<AnswerModel> answerList = data.entries.map((entry) {
      return AnswerModel.fromJson((entry));
    }).toList();

    "Answer List >>>> $answerList".logIt;

    return answerList;
  }
}
