class SplashState {
  final bool moveToNextScreen;

  SplashState({required this.moveToNextScreen});

  SplashState copyWith({bool? moveToNextScreen}) {
    return SplashState(
      moveToNextScreen: moveToNextScreen ?? this.moveToNextScreen,
    );
  }
}
