import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  TextEditingController scribe = TextEditingController();

  int currentIndex = 0;

  bool edit = false;

  // int listItems = 1;
  List<int> l = [1, 2];
  late double h;
  String title = 'Title';

  Future<void> navBar(index) async {
    currentIndex = index;

    emit(PageChanged());
  }

  void editButton() {
    edit = !edit;
    emit(EditButton());
  }

  double height(int listItems) {
    double height = 0;
    emit(Refrish());
    switch (listItems) {
      case 1:
        h = 110.0;
      case 2:
        h = 170.0;
      case 3:
        h = 150.0;
    }
    height = h;
    emit(ExpandSliverBar());
    return height;
  }

// void refresh(int index) {
//   listItems = index;
//   emit(Refrish());
// }
}
