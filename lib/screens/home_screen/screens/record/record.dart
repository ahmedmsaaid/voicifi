import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../cubits/data_cubit/date_cubit.dart';

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
          BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              return _mic(context);
            },
          ),
          SizedBox(
            height: 50.h,
          ),
          _buttons()
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
              replacement: Lottie.asset(
                  "assets/lotte_files/AnimationRecording.json",
                  fit: BoxFit.fitWidth,
                  width: 200,
                  alignment: Alignment.centerLeft),
              visible: DataCubit.get(context).isRecording,
              child: Row(
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
            ),
          ),
          painter: circule(),
        ),
      ),
    ],
  );
}

Widget _mic(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.skip_previous_outlined,
        size: 50,
        color: Colors.grey,
      ),
      IconButton(
          onPressed: () {
            DataCubit.get(context).startRecording();
          },
          icon: Visibility(
            visible: DataCubit.get(context).isRecording,
            replacement: InkWell(
              onTap: () {
                DataCubit.get(context).startRecording();
              },
              child: Lottie.asset("assets/lotte_files/stopRecording.json",
                  fit: BoxFit.fitWidth,
                  width: 50,
                  alignment: Alignment.centerLeft),
            ),
            child: Icon(
              Icons.mic,
              size: 40,
              color: Color(0xFF5435CF),
            ),
          )),
      Icon(
        Icons.skip_next_outlined,
        size: 60,
        color: Colors.grey,
      ),
    ],
  );
}

Widget _buttons() {
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

          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 15,
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
          // height: 40.h,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12.r),
          // ),
          // ,

          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.delete_outline, color: Colors.white)
            ],
          ),
        ),
      ),
      SizedBox(
        width: 8.w,
      ),
    ],
  );
}
