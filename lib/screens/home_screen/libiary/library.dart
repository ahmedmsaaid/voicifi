import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:voicify/data/cubits/home_cubit/home_cubit.dart';
import 'package:voicify/models/item_model/item_model.dart';

import '../../../translation/locate_keys.g.dart';
import '../../../widgets/delete/delete.dart';
import '../../../widgets/text_box/text_box.dart';

class Library extends StatelessWidget {
  const Library({super.key, required this.height});

  final double height;

  @override
  Widget build(
    BuildContext context,
  ) {
    var cubit = HomeCubit.get(context);

    cubit.getList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Color(0xFF6a1b9a),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              LocaleKeys.library.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return cubit.savedItems.isEmpty
                ? Center(
                    child: Lottie.asset('assets/lotte_files/empty.json',
                        repeat: false),
                  )
                : CustomScrollView(
                    slivers: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          cubit.savedItems;
                          return SliverAppBar(
                            backgroundColor: Colors.transparent,
                            automaticallyImplyLeading: false,
                            expandedHeight: 120.0.h,
                            floating: false,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Text(
                                      LocaleKeys.recent.tr(),
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return _item(
                                            index: index,
                                            context: context,
                                            model: cubit.savedItems[index]);
                                      },
                                      itemCount: 1,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 10.h),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            LocaleKeys.allRecords.tr(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return _item(
                                context: context,
                                model: cubit.savedItems[index],
                                index: index);
                          },
                          childCount: cubit.savedItems.length,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

Widget _item(
    {required BuildContext context,
    required ItemModel model,
    required int index}) {
  return Material(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(12.r),
    child: InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF6a1b9a)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      model.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      HomeCubit.get(context).displayTime(model.recordedTime!),
                      style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      DialogBox.showScribe(context, index);
                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color(0xFF542FB8),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Delete.deleteFromLib(context, index);
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFF542FB8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
