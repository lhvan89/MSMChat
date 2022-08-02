import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/pages/base_staless_widget.dart';
import 'package:msmchat/pages/room/room_cubit.dart';

import '../../manager/message_manager.dart';
import '../../models/message_model.dart';

class RoomPage extends BaseStatelessWidget<RoomCubit> {
  RoomPage({Key? key}) : super(key: key, cubit: RoomCubit());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PHÒNG CHAT'),
      ),
      body: FirebaseAnimatedList(
        controller: cubit.scrollController,
        query: MessageManager.instance.getListRoom(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          return Text('=======' + json.toString());
        },
      ),
    );
  }
}