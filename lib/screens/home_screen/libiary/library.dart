import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:voicify/data/cache/cache_helper.dart';
import 'package:voicify/data/cubits/data_cubit/date_cubit.dart';
import 'package:voicify/data/cubits/home_cubit/home_cubit.dart';
import 'package:voicify/models/item_model/item_model.dart';

import '../../../../widgets/text_box/text_box.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var cubit2 = DataCubit.get(context);
    cubit2.getList();
    var listItems = HomeCubit.get(context).height(cubit2.savedItems.length).h;
    return Container(
      decoration: BoxDecoration(
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
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          title: Center(
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
        body: BlocBuilder<DataCubit, DataState>(
          builder: (context, state) {
            return false
                // cubit2.myData == null || cubit2.myData.isEmpty
                ? Center(
                    child: Lottie.asset('assets/lotte_files/empty.json',
                        repeat: false),
                  )
                : CustomScrollView(
                    slivers: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          DataCubit.get(context).savedItems;
                          return SliverAppBar(
                            backgroundColor: Colors.transparent,
                            automaticallyImplyLeading: false,
                            expandedHeight: listItems,
                            floating: false,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Recent',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        cubit.l.add(1);
                                        cubit.height(cubit.l.length);

                                        // cubit.l.clear();
                                        //
                                        print(cubit.l.length);
                                      },
                                      child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return _item(
                                              index: index,
                                              context: context,
                                              model: cubit2.savedItems[index]);
                                        },
                                        itemCount: cubit2.savedItems.length <= 3
                                            ? cubit2.savedItems.length
                                            : 3,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 10),
                                      ),
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
                                model: cubit2.savedItems[index],
                                index: index);
                          },
                          childCount: cubit2.savedItems.length,
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
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF6a1b9a)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.title ?? '',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    model.date ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      DialogBox.showScribe(context, index);
                    },
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color(0xFF542FB8),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      DataCubit.get(context).remove(index);
                    },
                    icon: Icon(
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
