import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voicify/data/cubits/data_cubit/data_cubit.dart';
import 'package:path/path.dart' as p;
import '../../../models/api_model/transcribed.dart';
import '../../../models/item_model/item_model.dart';
import '../../../models/upload/save_url.dart';
import '../../cache/cache_helper.dart';
import '../../core/api/api_consumer.dart';
import '../../core/api/dio_consumer.dart';
import '../../core/api/end_points.dart';
import '../home_cubit/home_cubit.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit(this.api) : super(ApiInitial());
  final home = HomeCubit();
  final dataCubit = DataCubit(DioConsumer(dio: Dio()));

  static ApiCubit get(context) => BlocProvider.of<ApiCubit>(context);
  TextEditingController titleController = TextEditingController();
  TextEditingController scribe = TextEditingController();
  final ApiConsumer api;
  String path = '';
  String fileName = '';
  String? string = 'null';
  late FormData data = FormData.fromMap({});
  DateTime now = DateTime.now();

  bool edit = false;
  String scribeContent = '';

  String content = '';
  final myData = SharedHelper.getData('myData');

  void editButton() {
    edit = !edit;
    emit(EditButton());
  }

  void clear() {
    home.items.clear();
    emit(Cleared());
  }

  Future<void> refresh() async {
    emit(Refresh());
  }

  // void showScribe() {
  //   scribe.text = items.last.content!;
  //
  //   emit(Refresh());
  // }

  Future<void> pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result != null && result.files.isNotEmpty) {
        File file = File(result.files.single.path!);
        String fileName = p.basename(file.path);

        if (p.extension(fileName).toLowerCase() == '.mp3') {
          await _processAudioFile(file, fileName);
        } else {
          await _convertAndProcessAudioFile(file, fileName);
        }
      } else {
        throw Exception("لم يتم اختيار أي ملف.");
      }
    } catch (e) {
      throw Exception("خطأ في اختيار ملف الصوت: ${e.toString()}");
    }
  }

  Future<void> _processAudioFile(File file, String fileName) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    data = formData;
    this.fileName = fileName;
    titleController.text = fileName;
    print("تم معالجة الملف: $fileName");
  }

  Future<void> _convertAndProcessAudioFile(File file, String fileName) async {
    emit(LoadingConvertToMp3());
    try {
      String convertedPath = await _convertToMp3(file.path);
      await _processAudioFile(File(convertedPath), p.basename(convertedPath));
      emit(SuccessConvertToMp3());
    } catch (e) {
      emit(FailedConvertToMp3(msg: e.toString()));
      throw Exception("فشل تحويل الملف إلى MP3: $e");
    }
  }

  Future<String> _convertToMp3(String inputFilePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final outputFileName = '${p.basenameWithoutExtension(inputFilePath)}.mp3';
    final outputFilePath = p.join(directory.path, outputFileName);

    try {
      await FFmpegKit.execute(
          '-i "$inputFilePath" -acodec libmp3lame "$outputFilePath"');
      return outputFilePath;
    } catch (e) {
      print("خطأ أثناء تحويل الملف: $e");
      throw Exception("فشل تحويل الملف إلى MP3");
    }
  }

  Future<void> UploadToApi(FormData data) async {
    emit(LoadingUpload());
    SharedHelper.saveData(ApiKey.type, "application/octet-stream");
    try {
      final response = await api.post(EndPoints.upLoad, data: data);

      final SaveUrl model = SaveUrl.fromJson(response);

      print(
          '********************************************************************************');
      print(model.upload_url);
      await getId(model.upload_url);
      emit(SuccessUpload());
    } on DioException catch (e) {
      if (e.response != null) {
        emit(ErrorUpload(msg: "خطأ في رفع الملف:."));
        print("خطأ في رفع الملف: ${e.response}");
      } else {
        print("خطأ في الاتصال: ${e.message}");
      }
    } catch (e) {
      try {
        String err = jsonDecode(e.toString());
        print("خطأ غير متوقع: $err");
      } catch (jsonError) {
        emit(ErrorUpload(msg: "خطأ في رفع الملف:."));
        print("خطأ في تحليل JSON: ${e.toString()}");
      }
    }
  }

  Future<void> getId(String? url) async {
    emit(LoadingGitId());
    SharedHelper.saveData(ApiKey.type, "application/json");
    try {
      final responce = await api.post(EndPoints.transcript, data: {
        "audio_url": url,
        "language_detection": true,
        "speech_model": "nano"
      });
      final GetId model = GetId.fromJson(responce);

      SharedHelper.saveData(ApiKey.id, model.id);
      emit(SuccessGitId());
    } on Exception catch (e) {
      emit(ErrorGitId(msg: " Error getId ${e.toString()}"));
      print(" Error getId ${e.toString()}");
    }
  }

  Future<void> convert() async {
    emit(LoadingConvert());

    try {
      final response = await api.get(
        path: EndPoints.getId(SharedHelper.getData(ApiKey.id)),
      );

      final TranscpitedData model = TranscpitedData.fromJson(response);
      print("Response: $response");
      print("Text: ${model.text}");

      ItemModel item = ItemModel(
          content: model.text, recordedTime: now, title: '', index: 0);
      home.items.add(item);
      content = item.content ?? '';

      if (content.isEmpty) {
        await Future.delayed(const Duration(seconds: 5));
        await convert();
      } else {
        scribe.text = item.content ?? '';
        emit(SuccessConvert());
      }
    } on Exception catch (e) {
      emit(ErrorConvert(msg: "Error: ${e.toString()}"));
      print("Error: ${e.toString()}");
    }
  }

  Future<List<String>> generateTasks(String text) async {
    final response = await api.post(
      EndPoints.openApi,
      data: json.encode({
        'model': 'text-davinci-003', // أو استخدم GPT-4 إذا كان متاحًا
        'prompt': 'حول هذا الكلام إلى مجموعة مهام: $text',
        'max_tokens': 1000,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data['choices'][0]['text'] as String;

      // dataCubit.download(text, 'title');
      return result
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();
    } else {
      throw Exception('Failed to generate tasks');
    }
  }

  Future<void> convertAudioWithOpenApi(String text, String title) async {
    try {
      // if (path.isEmpty) {
      //   throw Exception(
      //       'Audio file path is empty. Please ensure getAudioContent is called first.');
      // }
      final systemMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "Start a new chat  and Return any message you are given in the same language in which the text was written and divide the text into task groups ",
          ),
          // OpenAIChatCompletionChoiceMessageContentItemModel.text(
          //   " :$text ",
          // ),
          // OpenAIChatCompletionChoiceMessageContentItemModel.text(text),
        ],
        role: OpenAIChatMessageRole.system,
      );
      final userMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            " :$text ",
          ),
          // OpenAIChatCompletionChoiceMessageContentItemModel.text(text),
        ],
        role: OpenAIChatMessageRole.system,
      );

      final requestMessages = [systemMessage, userMessage];
      OpenAIChatCompletionModel chatCompletion =
          await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo-1106",
        messages: requestMessages,
      );
      dataCubit.download(
          chatCompletion.choices.first.message.content!.first.text.toString(),
          title);
      print(
          chatCompletion.choices.first.message.content!.first.text.toString());
    } catch (e) {
      print('Error converting audio: $e');
    }
  }
}
