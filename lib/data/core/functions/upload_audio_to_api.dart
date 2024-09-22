import 'dart:io';

import 'package:dio/dio.dart';

Future<FormData?> uploadAudioToAPI(File? file) async {
  if (file == null) {
    return null; // إرجاع null إذا لم يكن هناك ملف
  }

  String fileName = file.path.split('/').last;
  FormData data = FormData.fromMap({
    "file": await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    ),
  });

  return data;
}
