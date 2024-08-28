import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/cubits/home_cubit/home_cubit.dart';

import '../../models/colors/app_colors.dart';

class DialogBox {
  static scribe(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              var cubit = HomeCubit.get(context);
              return Container(
                height: 400.h,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(children: [
                          Container(
                            child: cubit.edit
                                ? TextField(
                                    controller:
                                        HomeCubit.get(context).titleController,
                                    onTap: () {
                                      HomeCubit.get(context).showScribe();
                                      ;
                                    },
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            // fontSize: 15,
                                            // height: 300,
                                            color: Colors.black),
                                        // hintText: '',
                                        labelText: cubit.title,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    style: TextStyle(
                                        color: Colors.black,
                                        // height: 30,
                                        fontSize: 14),
                                  )
                                : Text(
                                    cubit.title,
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 300,
                            child: cubit.edit
                                ? TextField(
                                    controller: HomeCubit.get(context).scribe,
                                    onTap: () {
                                      HomeCubit.get(context).showScribe();
                                      ;
                                    },
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            // fontSize: 15,
                                            // height: 300,
                                            color: Colors.black),
                                        // hintText: '',
                                        labelText: cubit.scribeContent,
                                        helperText: 'Edit scribe here',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    style: TextStyle(
                                        color: Colors.black,
                                        // height: 30,
                                        fontSize: 14),
                                  )
                                : Text(
                                    cubit.scribeContent,
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          // border: Border.all(color: AppColors.blue),
                          // borderRadius: BorderRadius.circular(12)
                          ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: ImageIcon(
                                      AssetImage(
                                        'assets/icons/save.png',
                                      ),
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          IconButton(
                              onPressed: () {
                                cubit.editButton();
                              },
                              icon: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: ImageIcon(
                                      AssetImage('assets/icons/edit.png'),
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3.r),
                                    decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: ImageIcon(
                                      AssetImage('assets/icons/download.png'),
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: ImageIcon(
                                      AssetImage('assets/icons/share.png'),
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
