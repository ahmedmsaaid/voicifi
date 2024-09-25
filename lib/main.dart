import 'package:dart_openai/dart_openai.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voicify/data/core/api/end_points.dart';
import 'package:voicify/my_app.dart';
import 'data/cache/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/keys/keys.dart';
import 'firebase_options.dart';

void main() async {
  OpenAI.apiKey = Keys.openAi;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}
//  SHA1 :./gradlew signingReport
/// To Generate Local Translation Keys File
///
///
/// flutter pub run easy_localization:generate -S assets/translations -O lib/translation -o locate_keys.g.dart -f keys
