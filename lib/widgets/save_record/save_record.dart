import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:voicify/cubits/data_cubit/date_cubit.dart';
import 'package:voicify/models/colors/app_colors.dart';
import 'package:voicify/screens/home_screen/home_screen.dart';

import '../../cubits/home_cubit/home_cubit.dart';
import '../../models/item_model/item_model.dart';
import '../text_box/text_box.dart';

class SaveRecord {
  static save(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              var cubit = DataCubit.get(context);
              GlobalKey<FormState> formKey = GlobalKey<FormState>();

              return DataCubit.get(context).items.isNotEmpty
                  ? Container(
                      height: 100.h,
                      child: Column(
                        children: [
                          Text(
                            'File Title',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller:
                                  DataCubit.get(context).titleController,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Visibility(
                            visible: DataCubit.get(context).isTranscribing,
                            replacement: InkWell(
                              onTap: () {
                                if (DataCubit.get(context)
                                    .titleController
                                    .text
                                    .isNotEmpty) {
                                  DataCubit.get(context).startTranscribing();
                                }
                              },
                              child: Container(
                                width: 230.w,
                                height: 50,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 30.w),
                                decoration: BoxDecoration(
                                  color: AppColors.purple.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Transcribe',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 250.w,
                                  height: 50,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: LinearPercentIndicator(
                                    padding: EdgeInsets.zero,
                                    animationDuration: 2000,
                                    onAnimationEnd: () {
                                      DataCubit.get(context).transcribing();
                                    },
                                    barRadius: Radius.circular(12),
                                    animation: true,
                                    lineHeight: 50,
                                    percent: 1,
                                    backgroundColor: Colors.transparent,
                                    progressColor: AppColors.purple,
                                  ),
                                ),
                                Container(
                                  width: 230.w,
                                  height: 50,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 30.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.purple.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: cubit.is_done == false
                                      ? Text(
                                          'Transcribing Audio',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                          ),
                                        )
                                      : MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            DataCubit.get(context)
                                                .isTranscribing = false;
                                            DialogBox.scribe(context);
                                            HomeCubit.get(context).edit = false;
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Done',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Icon(
                                                Icons.check_circle_rounded,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Record voice first !',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
            },
          ),
        );
      },
    );
  }

  static saving(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              var cubit = DataCubit.get(context);

              return Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Saving',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                    ClipRRect(
                      clipBehavior: Clip.none,
                      child: Lottie.asset(
                        'assets/lotte_files/saving.json',
                        height: 100.h,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static done(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              var cubit = DataCubit.get(context);

              return Container(
                height: 200,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Done !',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      ),
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.blueAccent,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Center(
                        child: Text(
                          'Your Transcribed file hase been saved to your libiary ',
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue),
                        onPressed: () {
                          Navigator.pop(context);
                          HomeCubit.get(context).navBar(2);
                        },
                        child: Text(
                          'View Libiary',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
