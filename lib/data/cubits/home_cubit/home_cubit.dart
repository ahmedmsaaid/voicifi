import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/item_model/item_model.dart';
import '../../cache/cache_helper.dart';

part '../../../data/cubits/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  int currentIndex = 0;
  List<ItemModel> savedItems = [];
  bool edit = false;

  List<ItemModel> items = [];

  // int listItems = 1;
  List<int> l = [1, 2];
  double h = 50;
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

  String displayTime(DateTime time) {
    DateTime now = DateTime.now();

    // التحقق مما إذا كان الوقت المسجل هو في نفس اليوم
    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      // عرض الوقت فقط
      return DateFormat.jm().format(time); // تنسيق 12 ساعة
    } else {
      // عرض التاريخ والوقت
      return DateFormat('MM/dd/yyyy - hh:mm a')
          .format(time); // تنسيق 12 ساعة مع التاريخ
    }
  }

  void save(
    titleController,
    scribeController,
  ) {
    DateTime now = DateTime.now();
    ItemModel model = ItemModel(
        recordedTime: now,
        title: titleController.text,
        index: 0,
        content: scribeController.text);

    savedItems.add(model);
    saveToCache();

    titleController.clear();
    saveToCache();
    emit(Saved());
  }

  void saveToCache() async {
    try {
      List<String> itemsList = savedItems
          .map((itemModel) => jsonEncode(itemModel.toJson()))
          .toList();
      SharedHelper.saveData('myData', itemsList);
      print(itemsList.toString());
    } on Exception catch (e) {
      debugPrint('error $e');
    }
    emit(SavedToCache());
  }

  void getList() async {
    print("getList");
    var data = await SharedHelper.getData('myData'); // احصل على البيانات

    if (data == null || data.toString().isEmpty) {
      return;
    } else {
      try {
        List<String> itemsList =
            (data is List<String>) ? data : List<String>.from(data);

        if (itemsList.isNotEmpty) {
          savedItems = itemsList
              .map((item) => ItemModel.fromJson(json.decode(item)))
              .toList();
        }
        emit(GetData());
      } catch (e) {
        debugPrint('*******************error $e');
      }
    }
  }

  void remove(int index) {
    emit(Remove());
    savedItems.removeAt(index);
    for (int i = 0; i < savedItems.length; i++) {
      savedItems[i].index != i;
    }
    saveToCache();
    emit(Removed());
  }

// void refresh(int index) {
//   listItems = index;
//   emit(Refrish());
// }
}
