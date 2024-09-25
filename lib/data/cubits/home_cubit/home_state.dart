part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class PageChanged extends HomeState {}

final class ExpandSliverBar extends HomeState {}

final class Refrish extends HomeState {}

final class DrobDown extends HomeState {}

final class Scribe extends HomeState {}

final class EditButton extends HomeState {}

final class Remove extends HomeState {}

final class Removed extends HomeState {}

final class GetData extends HomeState {}

final class SavedToCache extends HomeState {}

final class Saved extends HomeState {}
