import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class BaseCubit extends Cubit<bool> {

  late BuildContext context;

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