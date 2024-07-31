import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_qa/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD3qxbCS_uR97eCZkNtqU2B98UGDCCkWSU",
      appId: "1:339016199100:android:04573ea4d5f6a34a1d19b9",
      messagingSenderId: "339016199100",
      projectId: "theqa-58df7",
    ),
  );

  await Hive.initFlutter();
  await Hive.openBox("userBox");

  runApp(const MyApp());
}
