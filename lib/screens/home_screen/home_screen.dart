import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/models/colors/app_colors.dart';
import 'package:voicify/screens/home_screen/home/home.dart';
import 'package:voicify/screens/home_screen/libiary/library.dart';
import 'package:voicify/screens/home_screen/record/record.dart';
import 'package:voicify/screens/home_screen/settings/settings.dart';
import 'package:voicify/screens/home_screen/upload/upload.dart';

import '../../data/cubits/home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const Home(),
      const Record(),
      Library(
          height: HomeCubit.get(context)
              .height(HomeCubit.get(context).savedItems.length)
              .h),
      const Upload(),
      const Settings(),
    ];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.purple,
          body: screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            selectedItemColor: AppColors.blue,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            onTap: (index) {
              cubit.navBar(index);
            },
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.transparent),
              const BottomNavigationBarItem(
                  icon: const Icon(Icons.mic),
                  label: 'Record',
                  backgroundColor: Colors.transparent),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_music),
                  label: 'Library',
                  backgroundColor: Colors.transparent),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                  backgroundColor: Colors.transparent),
              const BottomNavigationBarItem(
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
