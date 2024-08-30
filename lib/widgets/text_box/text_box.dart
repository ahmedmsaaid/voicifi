import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/cubits/data_cubit/date_cubit.dart';
import 'package:voicify/cubits/home_cubit/home_cubit.dart';
import 'package:voicify/models/item_model/item_model.dart';
import 'package:voicify/widgets/save_record/save_record.dart';

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
              ItemModel model = DataCubit.get(context).items[0];

              return model.content != null
                  ? Container(
                      height: 400.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(children: [
                                Container(
                                  child: cubit.edit
                                      ? TextField(
                                          controller: DataCubit.get(context)
                                              .titleController,
                                          onTap: () {
                                            DataCubit.get(context).showScribe();
                                            ;
                                          },
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  // fontSize: 15,
                                                  // height: 300,
                                                  color: Colors.black),
                                              // hintText: '',
                                              labelText:
                                                  "${DataCubit.get(context).titleController.text}",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                          style: TextStyle(
                                              color: Colors.black,
                                              // height: 30,
                                              fontSize: 14),
                                        )
                                      : Text(
                                          DataCubit.get(context)
                                              .titleController
                                              .text,
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
                                          controller:
                                              DataCubit.get(context).scribe,
                                          onTap: () {
                                            DataCubit.get(context).showScribe();
                                            ;
                                          },
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  // fontSize: 15,
                                                  // height: 300,
                                                  color: Colors.black),
                                              // hintText: '',
                                              labelText: model.content,
                                              helperText: 'Edit scribe here',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                          style: TextStyle(
                                              color: Colors.black,
                                              // height: 30,
                                              fontSize: 14),
                                        )
                                      : Text(
                                          DataCubit.get(context).content ?? '',
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
                                    onPressed: () {
                                      SaveRecord.saving(context);

                                      Future.delayed(
                                        Duration(seconds: 3),
                                        () => Navigator.pop(context),
                                      ).then((_) {
                                        Navigator.pop(context);
                                        DataCubit.get(context).save();
                                        DataCubit.get(context)
                                            .titleController
                                            .clear();

                                        SaveRecord.done(context);
                                      });
                                    },
                                    icon: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              // color:
                                              //     AppColors.purple.withOpacity(0.2),
                                              // border:
                                              // Border.all(color: AppColors.purple)

                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ImageIcon(
                                            color: AppColors.blue, size: 25,
                                            AssetImage(
                                              'assets/icons/save3.png',
                                            ),
                                            // color: Colors.white,
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
                                              border: Border.all(
                                                  color: AppColors.purple),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
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
                                              border: Border.all(
                                                  color: AppColors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ImageIcon(
                                            AssetImage(
                                                'assets/icons/download.png'),
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
                                              border: Border.all(
                                                  color: AppColors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ImageIcon(
                                            AssetImage(
                                                'assets/icons/share.png'),
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
                    )
                  : Center(
                      child: Text('Record voice first !'),
                    );
            },
          ),
        ),
      ),
    );
  }

  static showScribe(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              var cubit = HomeCubit.get(context);
              var cubit2 = DataCubit.get(context);

              return Container(
                height: 400.h,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(children: [
                          Container(
                            child: Text(
                              cubit2.savedItems[index].title ?? '',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 300,
                            child: Text(
                              cubit2.savedItems[index].content ?? '',
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: SizedBox()),
                          IconButton(
                              onPressed: () {
                                Future.delayed(
                                  Duration(seconds: 3),
                                  () => Navigator.pop(context),
                                ).then((_) {
                                  Navigator.pop(context);
                                  SaveRecord.done(context);
                                });
                              },
                              icon: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        // color:
                                        //     AppColors.purple.withOpacity(0.2),
                                        // border:
                                        // Border.all(color: AppColors.purple)

                                        borderRadius: BorderRadius.circular(5)),
                                    child: ImageIcon(
                                      color: AppColors.blue, size: 25,
                                      AssetImage(
                                        'assets/icons/download.png',
                                      ),
                                      // color: Colors.white,
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
                                        /* border:*/
                                        // Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: ImageIcon(
                                      AssetImage('assets/icons/share.png'),
                                      color: AppColors.purple,
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
