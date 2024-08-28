import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'date_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DateInitial());

  static DataCubit get(context) => BlocProvider.of<DataCubit>(context);
  bool isRecording = false;

  void startRecording() {
    isRecording = !isRecording;
    emit(StartRecording());
  }
}
