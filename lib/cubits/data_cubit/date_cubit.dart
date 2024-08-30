import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voicify/models/item_model/item_model.dart';

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
    ItemModel model = ItemModel(
        date: time,
        title: titleController.text,
        index: 0,
        content: items.last.content ?? '');
    savedItems.add(model);
    scribe.clear();
    titleController.clear();

    emit(StartRecording());
  }

  void showScribe() {
    scribe.text = items.last.content ?? '';

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
    if (speechToText.isListening) {
      final String time = '${now.hour - 12}-${now.minute.toString()}';

      ItemModel model = ItemModel(content: result.recognizedWords, date: time);
      content = result.recognizedWords;

      items.add(model);
      print("length of items is ${items.length}");

      emit(SpeechResult());

      print('speech********${model.content}');
      print('date********${model.date}');
      print(state);
    } else {
      of();
      print(TimeOut());
    }
  }

  void on() {
    isListening = true;
    emit(On());
  }

  void of() {
    isListening = false;
    emit(Of());
  }
// Future<void> speechEnabled() {}
}
