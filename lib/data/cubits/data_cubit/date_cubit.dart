import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voicify/data/cache/cache_helper.dart';
import 'package:voicify/models/item_model/item_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as p;
import '../../core/api/api_consumer.dart';
import '../home_cubit/home_cubit.dart';

part 'date_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit(
    this.api,
  ) : super(DateInitial());
  final home = HomeCubit();
  TextEditingController titleController = TextEditingController();
  TextEditingController scribe = TextEditingController();

  String content = '';
  DateTime now = DateTime.now();
  final myData = SharedHelper.getData('myData');

  static DataCubit get(context) => BlocProvider.of<DataCubit>(context);
  bool isRecording = false;
  bool isTranscribing = false;
  bool is_done = false;
  bool speechEnabled = false;
  bool isListening = false;
  String scribeContent = '';
  final ApiConsumer api;

  //Buttons

  void showScribe() {
    scribe.text = home.items.last.content!;

    emit(Scribe());
  }

  void startTranscribing() {
    isTranscribing = !isTranscribing;
    is_done = false;
    emit(StartRecording());
  }

  void transcribing() {
    is_done = true;
    emit(Transcribing());
  }

  //Speech Methods
  SpeechToText speechToText = SpeechToText();
  String localeId = 'ar-EG';
  late String dropdownValue = 'English';

  void setLange(String lang) async {
    switch (lang) {
      case 'ar-EG':
        {
          localeId = 'ar-EG';
          dropdownValue = 'English';
        }
        ;
      case 'en_US':
        {
          localeId = 'en_US';
          dropdownValue = 'العربيه';
        }
        ;
    }
    emit(LangChanged());
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    of();
    print(state);

    emit(InitSpeech());
  }

  void startListening() async {
    try {
      of();
      final options = SpeechListenOptions(
        cancelOnError: false,
        partialResults: true,
      );
      await speechToText.listen(
        onResult: onSpeechResult,
        localeId: localeId,
        listenFor: Duration(minutes: 10),
        pauseFor: Duration(seconds: 5),
        listenOptions: options,
      );

      print('Started listening');
      emit(StartListening());
    } catch (e) {
      print('Error starting listening: $e');
    }
  }

  void stopListening() async {
    await speechToText.stop();
    of();

    emit(StopListening());
  }

  void onSpeechResult(SpeechRecognitionResult result) async {
    if (speechToText.isListening) {
      content = result.recognizedWords;

      print(state);
    } else {
      of();
      print(TimeOut());
    }

    ItemModel model =
        ItemModel(content: content, recordedTime: now, title: '', index: 0);
    home.items.add(model);

    print("length of items is ${home.items.length}");
    print('speech********${model.content}');
    print('date********${model.recordedTime}');
    emit(SpeechResult());
  }

  void on() {
    isListening = true;
    emit(On());
  }

  void of() {
    isListening = false;
    emit(Of());
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  String downloadPath = '';

  String getTextDirection(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text) ? 'rtl' : 'ltr';
  }

  Future<void> download(String text, String title) async {
    final fontData = await rootBundle.load(
        'assets/fonts/ar/Amiri-Regular.ttf'); // استبدل المسار إذا لزم الأمر
    final ttf = pw.Font.ttf(fontData);
    await requestStoragePermission();

    //create pdf file
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          final direction = getTextDirection(text);
          return pw.Center(
            child: pw.Text(
              text,
              style: pw.TextStyle(
                font: ttf,
                fontSize: 24,
              ),
              textDirection: direction == 'rtl'
                  ? pw.TextDirection.rtl
                  : pw.TextDirection.ltr,
            ),
          );
        },
      ),
    );

    // Get the path to the downloads folder
    final downloadsDirectory = await getExternalStorageDirectory();
    final customPath = p.join(downloadsDirectory!.path, '$title.pdf');
    final file = File(customPath);

    try {
      // Save the PDF file
      await file.writeAsBytes(await pdf.save());
      print("تم حفظ PDF في: ${file.path}");
      downloadPath = "تم حفظ PDF في:${file.path}";
    } catch (e) {
      print("خطأ في حفظ PDF في مجلد التنزيلات: $e");

      // محاولة حفظ الملف في مسار آخر
      final alternativeDirectory = await getApplicationDocumentsDirectory();
      final alternativePath = p.join(alternativeDirectory.path, '$title.pdf');
      final alternativeFile = File(alternativePath);

      try {
        // حفظ مستند PDF في المسار البديل
        await alternativeFile.writeAsBytes(await pdf.save());
        print("تم حفظ PDF في المسار البديل: ${alternativeFile.path}");
        downloadPath = alternativeFile.path;
      } catch (e) {
        print("خطأ في حفظ PDF في المسار البديل: $e");
      }
    }
  }

  Future<void> downloadOnRoot(String text, String title) async {
    // طلب الأذونات
    await requestStoragePermission();

    // إنشاء مستند PDF
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(text),
          );
        },
      ),
    );

// Get the path to the downloads folder
    final downloadsDirectory = await getExternalStorageDirectory();
    final customPath = p.join(downloadsDirectory!.path, '$title.pdf');
    final file = File(customPath);

    try {
      // حفظ مستند PDF
      await file.writeAsBytes(await pdf.save());
      print("تم حفظ PDF في: ${file.path}");
    } catch (e) {
      print("خطأ في حفظ PDF: $e");
    }
  }

  Future<void> share(String text) async {
    await Clipboard.setData(ClipboardData(text: text)); // تم النسخ بنجاح

    final result = await Share.share(text);
    print(result);
  }
}

// To save the file in the> device
