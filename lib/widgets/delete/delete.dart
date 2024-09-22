import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/data/cubits/data_cubit/date_cubit.dart';
import 'package:voicify/data/cubits/home_cubit/home_cubit.dart';

class Delete {
  static done(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent.withOpacity(.6),
          contentPadding: EdgeInsets.zero,
          content: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.zero,
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(.5))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Done !',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static deleteFromRecord(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent.withOpacity(.6),
          contentPadding: EdgeInsets.zero,
          content: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              return HomeCubit.get(context).items.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(12.0.h),
                      child: Container(
                        padding: EdgeInsets.zero,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            'Nothing to delete ! ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.zero,
                      height: 120.h,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.grey.withOpacity(.5))),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(12.0.h),
                              child: Text(
                                'Are You Shore You Want Delete ? ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.r),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey)),
                                    child: Text(
                                      'No',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Delete.done(context);
                                    HomeCubit.get(context).items.clear();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.r),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey)),
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ],
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

  static deleteFromLib(
    BuildContext context,
    int index,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent.withOpacity(.6),
          contentPadding: EdgeInsets.zero,
          content: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.zero,
                height: 120.h,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(.5))),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0.h),
                        child: Text(
                          'Are You Shore You Want Delete ? ',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                'No',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                        MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Delete.done(context);
                              HomeCubit.get(context).remove(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey)),
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ],
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
}
