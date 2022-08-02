import 'dart:async';

import 'package:flutter/material.dart';
import 'package:msmchat/cubit/base_cubit.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../event_bus/event_bus.dart';

class ProfileCubit extends BaseCubit {

  BehaviorSubject<UserModel> userStream = BehaviorSubject();
  late StreamSubscription _reloadUserEvent;

  void getUser() {
    userStream.sink.add(AccountManager.instance.currentUser);
  }

  @override
  void initCubit() {
    super.initCubit();
    getUser();
    _reloadUserEvent = eventBus.on<ReloadUserEvent>().listen((event) {
      getUser();
    });
  }

  @override
  void dispose() {
    userStream.close();
    _reloadUserEvent.cancel();
    super.dispose();
  }

}