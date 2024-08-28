import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  TextEditingController scribe = TextEditingController();
  TextEditingController titleController = TextEditingController();
  int currentIndex = 0;

  bool edit = false;

  // int listItems = 1;
  List<int> l = [1, 2];
  late double h;
  String scribeContent =
      'Hier dreht sich alles um die Kunst und Kreativität von Barbara Meier, auch bekannt als Bara. Lassen Sie sich inspirieren von ihren einzigartigen Werken und erfahren Sie mehr über ihre Leidenschaft für Malerei, Grafikdesign und Drahtfiguren. Tauchen Sie ein in die faszinierende Welt der Wasserwelten und entdecken Sie, wie Barbara Meier Ideen auf den Punkt bringt. Besuchen Sie ihr Atelier für Malworkshops und lernen Sie selbst, die Farben zum Leben zu erwecken. Lassen Sie sich von der Kreativität begeistern!';
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
        h = 100.0;
      case 2:
        h = 160.0;
      case 3:
        h = 230.0;
    }
    height = h;
    emit(ExpandSliverBar());
    return height;
  }

  void showScribe() {
    scribe.text = scribeContent;
    emit(Scribe());
  }
// void refresh(int index) {
//   listItems = index;
//   emit(Refrish());
// }
}
