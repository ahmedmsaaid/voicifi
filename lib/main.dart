import 'package:dart_openai/dart_openai.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:voicify/my_app.dart';
import 'data/cache/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedHelper.init();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}
