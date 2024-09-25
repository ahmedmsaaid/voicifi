import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:voicify/data/cubits/home_cubit/home_cubit.dart';
import 'package:voicify/models/colors/app_colors.dart';
import 'package:voicify/screens/on_boarding/on_boarding.dart';
import 'package:voicify/translation/locate_keys.g.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black, // أسود رمادي
            Color(0xFF6a1b9a), // لون أرجواني داكن
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SuccessSignOut) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnBoardingScreen(),
                    ));
              }
            },
            listenWhen: (previous, current) {
              return current != previous;
            },
            child: ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
                  child: ListTile(
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
                          "${LocaleKeys.hi.tr()} ${AuthCubit.get(context).user.name}",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(LocaleKeys.welcome.tr(),
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.sp)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    LocaleKeys.homeTitle.tr(),
                    style: TextStyle(fontSize: 22.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: Text(LocaleKeys.homeHed.tr(),
                      style: TextStyle(fontSize: 22.sp)),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                      child: Text(LocaleKeys.appName.tr(),
                          style: TextStyle(fontSize: 21.sp)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                      child: Text(LocaleKeys.homeDescription1.tr(),
                          style: TextStyle(fontSize: 16.sp)),
                    ),
                  ],
                ),
                Descriptions(context),
                SizedBox(
                  height: 30.h,
                ),
                _circle(),
                _button(h, w, context),
                _container(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget enDescriptions(String test) {
  return Padding(
    padding: EdgeInsets.fromLTRB(8.0.w, 0, 8.w, 4.h),
    child: Text(test),
  );
}

Widget Descriptions(context) {
  return HomeCubit.get(context).lang
      ? Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
              "${LocaleKeys.homeDescription2.tr()}${LocaleKeys.homeDescription3.tr()}${LocaleKeys.homeDescription4.tr()}${LocaleKeys.homeDescription5.tr()} "),
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            enDescriptions(LocaleKeys.homeDescription2.tr()),
            enDescriptions(LocaleKeys.homeDescription3.tr()),
            enDescriptions(LocaleKeys.homeDescription4.tr()),
            enDescriptions(LocaleKeys.homeDescription5.tr()),
          ],
        );
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF542FB8) // لون الدائرة
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
      SizedBox(
        width: 180.w,
        height: 180.h,
        child: CustomPaint(
          painter: CirclePainter(),
          child: const Align(
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
        color: const Color(0xFF542FB8),
        onPressed: () {
          HomeCubit.get(context).navBar(1);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              LocaleKeys.startRecording.tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.mic, color: Colors.white),
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
              color: const Color(0xFF542FB8),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              LocaleKeys.seeHowVoiceScribeWorks.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            HomeCubit.get(context).lang
                ? Icon(
                    Icons.arrow_circle_left,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.arrow_circle_right,
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
      color: Colors.transparent.withOpacity(.9),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.white,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      icon: const Icon(
        Icons.more_vert_outlined,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: 'Settinsg',
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                HomeCubit.get(context).navBar(4);
              },
              child: Text(
                LocaleKeys.settings.tr(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'About Us',
            child: MaterialButton(
              onPressed: () {},
              child: Text(
                LocaleKeys.aboutUs.tr(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'Log Out',
            child: MaterialButton(
              onPressed: () {
                AuthCubit.get(context).signOut();
              },
              child: Text(
                LocaleKeys.signOut.tr(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ];
      });
}
