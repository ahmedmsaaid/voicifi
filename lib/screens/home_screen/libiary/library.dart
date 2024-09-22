import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:voicify/data/cubits/home_cubit/home_cubit.dart';
import 'package:voicify/models/item_model/item_model.dart';

import '../../../widgets/delete/delete.dart';
import '../../../widgets/text_box/text_box.dart';

class Library extends StatelessWidget {
  Library({super.key, required this.height});

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
            const Color(0xFF6a1b9a),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Library',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
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
                            expandedHeight: 110.0.h,
                            floating: false,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Recent',
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
                                          const SizedBox(height: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'All records',
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      HomeCubit.get(context).displayTime(model.recordedTime!),
                      style: const TextStyle(color: Colors.white),
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
