import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image(
                image: Image.asset(
              'assets/images/mic.png',
              cacheHeight: 400,
            ).image),
            Stack(children: [
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0a3164), Color(0xFF6a1b9a)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    // color: const Color(0xFF610994),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(1),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -230.h,
                right: -97.w,
                child: CircleAvatar(
                  radius: 305.r,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 4, 5, 5),
                          Color(0xFF6a1b9a),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 450.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.h,
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
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          'Development of an offline-first mobile snagging application for Disneyland Paris, streamlining information gathering for technical experts in the field and enhancing communication with maintenance services for problem-solving.',
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: GoogleFonts.abel(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 150.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Get Start',
                                  style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_right, color: Colors.white)
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
