part of 'api_cubit.dart';

@immutable
sealed class ApiState {}

final class ApiInitial extends ApiState {}

final class LoadingPicFile extends ApiState {}

final class SuccessPicFile extends ApiState {}

final class ErrorPicFile extends ApiState {
  final String msg;

  ErrorPicFile({required this.msg});
}

final class LoadingUpload extends ApiState {}

final class SuccessUpload extends ApiState {}

final class ErrorUpload extends ApiState {
  final String msg;

  ErrorUpload({required this.msg});
}

final class LoadingGitId extends ApiState {}

final class SuccessGitId extends ApiState {}

final class ErrorGitId extends ApiState {
  final String msg;

  ErrorGitId({required this.msg});
}

final class LoadingConvert extends ApiState {}

final class SuccessConvert extends ApiState {}

final class ErrorConvert extends ApiState {
  final String msg;

  ErrorConvert({required this.msg});
}

final class EditButton extends ApiState {}

final class Cleared extends ApiState {}

final class Save extends ApiState {}

final class SavedToCache extends ApiState {}

final class Refresh extends ApiState {}
