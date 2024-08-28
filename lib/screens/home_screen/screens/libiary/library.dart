import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/cubits/home_cubit/home_cubit.dart';

import '../../../../widgets/text_box/text_box.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var listItems = HomeCubit.get(context).height(cubit.l.length).h;
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
        body: CustomScrollView(
          slivers: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) {
                return current != previous;
              },
              builder: (context, state) {
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
                            style: TextStyle(fontSize: 22, color: Colors.white),
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
                                return _item(context: context);
                              },
                              itemCount:
                                  cubit.l.length <= 3 ? cubit.l.length : 3,
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _item(context: context),
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _item({required BuildContext context}) {
  return Material(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        DialogBox.scribe(context);
      },
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
                  'app_time_stats: avg=26781.04ms',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  'App Time',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Color(0xFF542FB8),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
  );
}
