import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/data/cubits/api_cubit/api_cubit.dart';
import 'package:voicify/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:voicify/models/colors/app_colors.dart';
import 'package:voicify/my_app.dart';
import 'package:voicify/screens/home_screen/home/home.dart';
import 'package:voicify/screens/home_screen/home_screen.dart';
import 'package:voicify/translation/locate_keys.g.dart';
import 'package:voicify/widgets/reset_password/reset_password.dart';

import '../signUp_screen/signUp_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey<FormState>();
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
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SuccessSignIn ||
                    state is SuccessSignUpWithGoogle) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                } else {
                  if (state is FailedSignIn)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.err),
                      ),
                    );
                }
              },
              builder: (context, state) {
                var cubit = AuthCubit.get(context);
                return Form(
                  key: form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image(image: Image.asset("assets/images/mic2.png").image),
                      Center(
                        child: Text(
                          LocaleKeys.signIn.tr(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      TextField(
                        controller: cubit.email,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: LocaleKeys.email.tr(),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white), // للحد الصريح
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: cubit.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: LocaleKeys.password.tr(),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white), // للحد الصريح
                          ),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              ResetPassword.reset(context);
                            },
                            child: Text(
                              textAlign: TextAlign.start,
                              LocaleKeys.forgottenPassword.tr(),
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await cubit.signIn();

                            // cubit.signUp();
                            // Handle login action
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.grey, width: 1.w),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            backgroundColor: AppColors.purple
                                .withOpacity(.3), // Button color
                          ),
                          child: state is LoadingSignIn
                              ? Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : Text(
                                  LocaleKeys.signIn.tr(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Center(child: Text("OR")),
                      SizedBox(height: 10.h),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await cubit.signInWithGoogle().then((_) {
                              if (state is SuccessSignUpWithGoogle) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              } else {
                                if (state is FailedSignIn)
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.err),
                                    ),
                                  );
                              }
                            });
                            // Handle login action
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.grey, width: 1.w),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            backgroundColor: AppColors.purple
                                .withOpacity(.3), // Button color
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Image.asset(
                                  "assets/images/gmail.png",
                                ),
                              ),
                              state is LoadingSignUpWithGoogle
                                  ? Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : Text(
                                      LocaleKeys.signInGoogle.tr(),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(LocaleKeys.dontHaveAccount.tr()),
                          SizedBox(
                            width: 20.w,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ));
                              // Handle register
                            },
                            child: Text(
                              LocaleKeys.signUp.tr(),
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
