import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_screen/home_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Image.asset(
                'assets/images/mic2.png',
                fit: BoxFit.cover, // لضمان ملء الصورة
              ),
            ),
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
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
                    child: texts(context),
                  ),
                  ClipPath(
                    clipper: ContanerWithCircle(),
                    child: Container(
                      height: 80.h,
                      width: double.infinity,
                      color: Theme.of(context).cardColor ,


                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget texts(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 25.h,
      ),
      Text(
        'Voicify',
        style: GoogleFonts.abel(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 40.sp,
          ),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
      Text(
        'Your speech to Text Converter',
        style: GoogleFonts.abel(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          'Development of an offline-first mobile snagging application for Disneyland Paris, streamlining information gathering for technical experts in the field and enhancing communication with maintenance services for problem-solving.',
          overflow: TextOverflow.clip,
          maxLines: 4,
          style: GoogleFonts.abel(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
      SizedBox(height: 60.h,),
      SizedBox(
        width: 220.w,
        height: 30.h,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.deepPurpleAccent),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Get Start',
                  style: GoogleFonts.abel(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, color: Colors.white)
              ],
            )),
      )
    ],
  );
}

class ContanerWithCircle extends CustomClipper<Path> {
  var path = Path();
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(w * 0.5, h -150, w, h);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
