import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  int currentIndex = 0;

  // int listItems = 1;
  List<int> l = [
    1,
  ];
  late double h;

  Future<void> navBar(index) async {
    currentIndex = index;

    emit(PageChanged());
  }

  double height(int listItems) {
    double height = 0;
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

// void refresh(int index) {
//   listItems = index;
//   emit(Refrish());
// }
}
