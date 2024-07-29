import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_qa/_util/app_constant.dart';
import 'package:the_qa/google_auth/controller/google_auth_event.dart';
import 'package:the_qa/google_auth/controller/google_auth_state.dart';
import 'package:the_qa/google_auth/repository/google_auth_repository.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  GoogleAuthBloc() : super(GoogleAuthState.initial()) {
    on<SignInEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true, signInSuccess: false));
        UserCredential userCredential =
            await GoogleAuthRepositoryImpl().signInWithGoogle();

        DatabaseReference ref = firebaseDatabase
            .ref("users/${userCredential.user!.providerData[0].uid}");

        await ref.set({
          "userId": userCredential.user!.providerData[0].uid,
          "name": userCredential.user!.displayName,
          "email": userCredential.user!.email,
          "image": userCredential.user!.photoURL,
        });
        userId = userCredential.user!.providerData[0].uid!;

        await Hive.box("userBox").put(
          "userId",
          userCredential.user!.providerData[0].uid,
        );

        emit(
          state.copyWith(
            userName: userCredential.user!.displayName,
            signInSuccess: true,
            isLoading: false,
          ),
        );
      },
    );
  }
}
