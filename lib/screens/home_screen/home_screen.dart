import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicify/screens/home_screen/screens/home/home.dart';
import 'package:voicify/screens/home_screen/screens/libiary/library.dart';
import 'package:voicify/screens/home_screen/screens/record/record.dart';
import 'package:voicify/screens/home_screen/screens/settings/settings.dart';
import 'package:voicify/screens/home_screen/screens/upload/upload.dart';

import '../../cubits/home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      Home(),
      Record(),
      Library(),
      Upload(),
      Settings(),
    ];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xFF6a1b9a),
          body: screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            selectedItemColor: Color(0xFF5435CF),
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            onTap: (index) {
              cubit.navBar(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mic),
                  label: 'Record',
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_music),
                  label: 'Libiary',
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                  backgroundColor: Colors.transparent),
            ],
          ),
        );
      },
    );
  }
}
