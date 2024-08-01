import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/splash/controller/splash_event.dart';
import 'package:the_qa/splash/controller/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState(moveToNextScreen: false)) {
    on<MoveToHomeScreen>(
      (event, emit) {
        emit(state.copyWith(moveToNextScreen: true));
      },
    );
  }
}
