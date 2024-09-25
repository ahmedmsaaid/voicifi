part of 'data_cubit.dart';

@immutable
sealed class DataState {}

final class DateInitial extends DataState {}

final class StartRecording extends DataState {}

final class Transcribing extends DataState {}

final class InitSpeech extends DataState {}

final class StartListening extends DataState {}

final class StopListening extends DataState {}

final class SpeechResult extends DataState {}

final class LoadingSpeechResult extends DataState {}

final class TimeOut extends DataState {}

final class On extends DataState {}

final class Of extends DataState {}

final class LangChanged extends DataState {}

final class Scribe extends DataState {}

final class Removed extends DataState {}

final class Remove extends DataState {}

final class Cleared extends DataState {}

final class Downloaded extends DataState {}

final class SavedToCache extends DataState {}

final class GetData extends DataState {}
