part of 'date_cubit.dart';

@immutable
sealed class DataState {}

final class DateInitial extends DataState {}

final class StartRecording extends DataState {}
