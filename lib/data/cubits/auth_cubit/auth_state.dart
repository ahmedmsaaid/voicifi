part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingSignIn extends AuthState {}

final class SuccessSignIn extends AuthState {}

final class FailedSignIn extends AuthState {
  final String err;

  FailedSignIn({required this.err});
}

final class LoadingSignUp extends AuthState {}

final class SuccessSignUp extends AuthState {}

final class FailedSignUp extends AuthState {
  final String err;

  FailedSignUp({required this.err});
}

final class LoadingSignUpWithGoogle extends AuthState {}

final class SuccessSignUpWithGoogle extends AuthState {}

final class EmailUsed extends AuthState {}

final class FailedSignUpWithGoogle extends AuthState {
  final String err;

  FailedSignUpWithGoogle({required this.err});
}

final class LoadingAddUserFireStore extends AuthState {}

final class SuccessAddUserFireStore extends AuthState {}

final class FailedAddUserFireStore extends AuthState {
  final String err;

  FailedAddUserFireStore({required this.err});
}

final class LoadingGetUserFireStore extends AuthState {}

final class SuccessGetUserFireStore extends AuthState {}

final class FailedGetUserFireStore extends AuthState {
  final String err;

  FailedGetUserFireStore({required this.err});
}

final class LoadingSignOut extends AuthState {}

final class SuccessSignOut extends AuthState {}

final class FailedSignOut extends AuthState {
  final String err;

  FailedSignOut({required this.err});
}

final class LoadingSendLink extends AuthState {}

final class SuccessSendLink extends AuthState {}

final class FailedSendLink extends AuthState {
  final String err;

  FailedSendLink({required this.err});
}

final class Cleared extends AuthState {}
