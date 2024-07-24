class GoogleAuthState {
  final bool isLoading;
  final bool signInSuccess;
  final String userName;

  GoogleAuthState(
      {required this.isLoading,
      required this.userName,
      required this.signInSuccess});

  factory GoogleAuthState.initial() =>
      GoogleAuthState(isLoading: false, userName: "", signInSuccess: false);

  GoogleAuthState copyWith(
      {bool? isLoading, String? userName, bool? signInSuccess}) {
    return GoogleAuthState(
        isLoading: isLoading ?? this.isLoading,
        userName: userName ?? this.userName,
        signInSuccess: signInSuccess ?? this.signInSuccess);
  }
}
