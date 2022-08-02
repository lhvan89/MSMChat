import 'package:bloc/bloc.dart';

class BaseCubit extends Cubit<bool> {
  BaseCubit() : super(false) {
    initCubit();
  }

  void initCubit() {}

  @override
  Future<void> close() {
    dispose();
    return super.close();
  }

  void dispose() {}
}