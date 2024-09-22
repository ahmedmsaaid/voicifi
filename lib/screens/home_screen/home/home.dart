import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/data/cubits/home_cubit/home_cubit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black, // أسود رمادي
            Color(0xFF6a1b9a), // لون أرجواني داكن
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        children: [
          ListTile(
            trailing: _popUoButton(),
            leading: CircleAvatar(
              backgroundImage: Image.network(
                      'https://img.freepik.com/free-vector/young-bearded-man_24877-82119.jpg')
                  .image,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi Ahmed',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text('Wilcome',
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Convert speech to text ',
              style: TextStyle(fontSize: 22.sp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
            child: Text('Effortlessly !', style: TextStyle(fontSize: 22.sp)),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                child: Text('Voicify', style: TextStyle(fontSize: 21.sp)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: Text('App is your reliable companion for ',
                    style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0.w, 0, 8.w, 4.h),
            child: Text('converting spoken words into written text. Using '),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0.w, 0, 8.w, 4.h),
            child: Text('advanced speech recognition technology, we'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0.w, 0, 8.w, 4.h),
            child: Text('transcribe your words, ideas, conversations into '),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0.w, 0, 8.w, 4.h),
            child: Text(' editable text. Let the words flow!'),
          ),
          SizedBox(
            height: 30.h,
          ),
          _circle(),
          _button(h, w, context),
          _container(context),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF542FB8) // لون الدائرة
      ..style = PaintingStyle.stroke // نوع الرسم (ملء)
      ..strokeWidth = 4;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2), // مركز الدائرة
      size.width / 2, // نصف القطر
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget _circle() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 180.w,
        height: 180.h,
        child: CustomPaint(
          child: Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.multitrack_audio_sharp,
                    size: 25, color: Color(0xFF542FB8)),
                Icon(Icons.multitrack_audio_sharp,
                    size: 25, color: Color(0xFF542FB8)),
                Icon(
                  Icons.multitrack_audio_sharp,
                  size: 30,
                  color: Color(0xFF542FB8),
                ),
                Icon(
                  Icons.multitrack_audio_sharp,
                  size: 25,
                  color: Color(0xFF542FB8),
                ),
              ],
            ),
          ),
          painter: CirclePainter(),
        ),
      ),
    ],
  );
}

Widget _button(h, w, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: w * .25, vertical: 20.h),
    child: MaterialButton(
        height: 40.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        color: Color(0xFF542FB8),
        onPressed: () {
          HomeCubit.get(context).navBar(1);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Start Recording',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            ),
            Icon(Icons.mic, color: Colors.white),
          ],
        )),
  );
}

Widget _container(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        HomeCubit.get(context).navBar(1);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 3,
              color: Color(0xFF542FB8),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'See How VoiceScribe Works!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_circle_right_sharp,
              color: Colors.white,
            )
          ],
        ),
      ),
    ),
  );
}

Widget _popUoButton() {
  return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert_outlined,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
            child: MaterialButton(
              onPressed: () {
                HomeCubit.get(context).navBar(4);
              },
              child: Text('Settinsg'),
            ),
            value: 'Settinsg',
          ),
          PopupMenuItem(
            child: MaterialButton(
              onPressed: () {},
              child: Text('Abput Us'),
            ),
            value: 'Abput Us',
          ),
          PopupMenuItem(
            child: MaterialButton(
              onPressed: () {},
              child: Text('Log Out'),
            ),
            value: 'Log Out',
          )
        ];
      });
}
