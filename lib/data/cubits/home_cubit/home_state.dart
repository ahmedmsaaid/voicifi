part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class PageChanged extends HomeState {}

final class ExpandSliverBar extends HomeState {}

final class Refrish extends HomeState {}

final class Scribe extends HomeState {}

final class EditButton extends HomeState {}
