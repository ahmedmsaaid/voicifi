import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:voicify/data/cubits/auth_cubit/auth_cubit.dart';

import '../../data/cubits/api_cubit/api_cubit.dart';
import '../../models/colors/app_colors.dart';
import '../../translation/locate_keys.g.dart';

class ResetPassword {
  static reset(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: BlocBuilder<ApiCubit, ApiState>(
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return SizedBox(
                height: 100.h,
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.enterYourEmail.tr(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: cubit.email,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        // يمكنك إضافة بعض الخصائص هنا إذا كنت ترغب
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 230.w,
                      height: 50,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 30.w),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          await cubit.resetPassword(cubit.email.text);
                          Navigator.pop(context);
                          resetDone(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.sendResetLink.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static resetDone(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey)),
                height: 150.h,
                width: 200.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.doneCheckYoreEmail.tr()),
                    SizedBox(
                      child: Lottie.asset('assets/lotte_files/send_link.json',
                          width: 80.w, height: 80.h, repeat: false),
                    ),
                  ],
                ),
              ));
        });
  }
}
