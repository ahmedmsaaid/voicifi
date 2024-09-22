import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';

Future uploadImageToAPI(XFile? image) async {
  return MultipartFile.fromFile(image!.path,
      filename: image.path.split('/').last);
}
