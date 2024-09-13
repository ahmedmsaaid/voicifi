import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voicify/models/item_model/item_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'date_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DateInitial());
  TextEditingController titleController = TextEditingController();
  TextEditingController scribe = TextEditingController();
  List<ItemModel> items = [];
  List<ItemModel> savedItems = [];
  String content = 'ahmed';
  DateTime now = DateTime.now();

  static DataCubit get(context) => BlocProvider.of<DataCubit>(context);
  bool isRecording = false;
  bool isTranscribing = false;
  bool is_done = false;
  bool speechEnabled = false;
  bool isListening = false;
  String scribeContent = '';

  //Buttons
  void save() {
    final String time = '${now.hour - 12}-${now.minute.toString()}';
    content = content + scribe.text;
    ItemModel model = ItemModel(
        date: time, title: titleController.text, index: 0, content: content);
    savedItems.add(model);

    titleController.clear();
    clear();
    print(content);
    emit(StartRecording());
  }

  void clear() {
    items.clear();
    emit(Cleared());
  }

  void remove(int index) {
    emit(Remove());
    savedItems.removeAt(index);
    for (int i = 0; i < savedItems.length; i++) {
      savedItems[i].index != i;
    }
    emit(Removed());
  }

  void showScribe() {
    scribe.text = items.last.content!;

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
          listenOptions: options);
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
    final String time = '${now.hour - 12}-${now.minute.toString()}';
    if (speechToText.isListening) {
      content = result.recognizedWords;

      print(state);
    } else {
      of();
      print(TimeOut());
    }

    ItemModel model =
        ItemModel(content: content, date: time, title: '', index: 0);
    items.add(model);
    print("length of items is ${items.length}");
    print('speech********${model.content}');
    print('date********${model.date}');
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

  Future<void> requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> download(String text) async {
    requestPermission();
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(text),
          ); // Center
        },
      ),
    );

    // الحصول على مسار التخزين
    final customPath = 'cache/pdf';
    final file = File(customPath);

    // حفظ المستند
    await file.writeAsBytes(await pdf.save());

    // طباعة النص في وحدة التحكم
    print("Text to be printed in PDF: $text");

    emit(Downloaded());
    print("PDF saved at: ${file.path}");
  }
// Future<void> speechEnabled() {}
}
