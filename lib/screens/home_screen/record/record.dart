import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:voicify/widgets/delete/delete.dart';
import 'package:voicify/widgets/save_record/save_record.dart';

import '../../../../data/cubits/data_cubit/date_cubit.dart';
import '../../../../models/colors/app_colors.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black, // أسود رمادي
            Color(0xFF6a1b9a), // لون أرجواني داكن
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            title: Center(
                child: Text(
              'Input Speech',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            )),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: h * 0.04),
            child: Text(
              'Press Microphone Icon To Recording Your ',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              'Speech',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              return _circle(context);
            },
          ),
          SizedBox(
            height: 50.h,
          ),
          _mic(context),
          SizedBox(
            height: 50.h,
          ),
          _buttons(context),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.purple,
                  )),
              child: IconButton(
                onPressed: () {
                  Delete.delete(context);
                },
                icon: Icon(
                  Icons.delete_outline_outlined,
                  size: 30.r,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class circule extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF5435CF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.height / 2, paint);

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

Widget _circle(context) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 180.w,
        height: 180.h,
        child: CustomPaint(
          child: Align(
            alignment: Alignment.center,
            child: Visibility(
                replacement: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.multitrack_audio,
                        size: 40, color: Color(0xFF542FB8)),
                    Icon(Icons.multitrack_audio_sharp,
                        size: 60, color: Color(0xFF542FB8)),
                    Icon(Icons.multitrack_audio_sharp,
                        size: 40, color: Color(0xFF542FB8)),
                  ],
                ),
                visible: DataCubit.get(context).isListening,
                child: Lottie.asset(
                    "assets/lotte_files/AnimationRecording.json",
                    fit: BoxFit.fitWidth,
                    width: 200.w,
                    alignment: Alignment.centerLeft)),
          ),
          painter: circule(),
        ),
      ),
    ],
  );
}

Widget _mic(context) {
  return BlocBuilder<DataCubit, DataState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.skip_previous_outlined,
            size: 50,
            color: Colors.grey,
          ),
          Visibility(
            child: IconButton(
              onPressed: () {
                DataCubit.get(context).stopListening();
                DataCubit.get(context).of();
              },
              icon: Lottie.asset("assets/lotte_files/stopRecording.json",
                  fit: BoxFit.fitWidth,
                  width: 50,
                  alignment: Alignment.centerLeft),
            ),
            replacement: IconButton(
              onPressed: () {
                DataCubit.get(context).startListening();
                DataCubit.get(context).on();
              },
              icon: Icon(
                Icons.mic,
                size: 40,
                color: Color(0xFF5435CF),
              ),
            ),
            visible: DataCubit.get(context).isListening,
          ),
          // InkWell(
          //   onTap: () {
          //
          //         ?
          //         :
          //   },
          //   child: Visibility(
          //     visible: DataCubit.get(context).isListening,

          //   ),
          // ),

          Icon(
            Icons.skip_next_outlined,
            size: 60,
            color: Colors.grey,
          ),
        ],
      );
    },
  );
}

Widget _buttons(context) {
  return BlocBuilder<DataCubit, DataState>(
    builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5435CF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              // height: 40.h,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(12.r),
              // ),
              // ,

              onPressed: () {
                SaveRecord.save(
                  context,
                );
                DataCubit.get(context).of();
                DataCubit.get(context).stopListening();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Icon(Icons.arrow_circle_right_outlined, color: Colors.white)
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6a1b9a).withOpacity(.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF5435CF)))),

              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(12.r),
              // ),

              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Lang',
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(12),
                      dropdownColor: Colors.transparent.withOpacity(0.4),
                      value: DataCubit.get(context).localeId,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          DataCubit.get(context).setLange(value.toString());
                          print(DataCubit.get(context).localeId);
                        }
                      },
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('عربي'),
                          value: 'ar-EG',
                          onTap: () {},
                        ),
                        DropdownMenuItem<String>(
                          child: Text('English'),
                          value: 'en_US',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
        ],
      );
    },
  );
}
