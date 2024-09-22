import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicify/data/cubits/api_cubit/api_cubit.dart';
import 'package:voicify/widgets/upload/upload_widgets.dart';

import '../../../widgets/save_record/save_record.dart';

class Upload extends StatelessWidget {
  const Upload({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiCubit, ApiState>(
      builder: (context, state) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    ApiCubit.get(context).pickAudioFile();
                    SaveRecord.loading(context);
                    Future.delayed(Duration(seconds: 5)).then((_) async {
                      Navigator.pop(context);

                      UploadWidgets.pickFile(
                        context,
                      );

                      ApiCubit.get(context).content = "";
                    });
                    // UploadWidgets.upload(context, state);
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          size: 80,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Upload',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Upload your Audio To  convert it to text ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Center(
              //   child: InkWell(
              //     onTap: () {
              //       UploadWidgets.processing(context);
              //     },
              //     child: Container(
              //       width: 200,
              //       height: 100,
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: [Colors.blue, Colors.purple],
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //         ),
              //         borderRadius: BorderRadius.circular(20),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black26,
              //             blurRadius: 10,
              //             offset: Offset(0, 5),
              //           ),
              //         ],
              //       ),
              //       child: Column(
              //         children: [
              //           Icon(
              //             Icons.text_fields_outlined,
              //             size: 50,
              //             color: Colors.white,
              //           ),
              //           SizedBox(height: 10),
              //           Text(
              //             'Next',
              //             style: TextStyle(
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
