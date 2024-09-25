import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voicify/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:voicify/models/colors/app_colors.dart';
import 'package:voicify/my_app.dart';
import 'package:voicify/screens/home_screen/home/home.dart';
import 'package:voicify/screens/home_screen/home_screen.dart';
import 'package:voicify/screens/signIn_screen/signIn_screen.dart';

import '../../translation/locate_keys.g.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                if (state is SuccessSignUp) {
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
                    children: <Widget>[
                      Image(image: Image.asset("assets/images/mic2.png").image),
                      Text(
                        LocaleKeys.signUp.tr(),
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      TextField(
                        controller: cubit.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: LocaleKeys.name.tr(),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white), // للحد الصريح
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 20),
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
                      SizedBox(height: 40.h),
                      ElevatedButton(
                        onPressed: () async {
                          await cubit.signUp().then((_) {
                            if (state is SuccessSignUp) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(LocaleKeys.signUpSuccess.tr()),
                                backgroundColor: Colors.green,
                              ));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            }
                          });
                          // cubit.signUp();
                          // Handle login action
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.grey, width: 2),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          backgroundColor:
                              AppColors.purple.withOpacity(.3), // Button color
                        ),
                        child: state is LoadingSignUp
                            ? Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : Text(
                                LocaleKeys.signUp.tr(),
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                      ),
                      SizedBox(height: 10.h),
                      Text(LocaleKeys.or.tr()),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          cubit.signInWithGoogle();
                          // Handle login action
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.grey, width: 2.w),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          backgroundColor:
                              AppColors.purple.withOpacity(.3), // Button color
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                "assets/images/gmail.png",
                              ),
                            ),
                            Text(
                              LocaleKeys.sigUpnGoogle.tr(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            LocaleKeys.alreadyHaveAccount.tr(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ));
                            },
                            child: Text(
                              LocaleKeys.signIn.tr(),
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
