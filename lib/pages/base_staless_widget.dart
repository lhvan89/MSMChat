import 'package:flutter/cupertino.dart';
import 'package:msmchat/cubit/base_cubit.dart';


abstract class BaseStatelessWidget<C extends BaseCubit> extends StatelessWidget {
  final C cubit;

  const BaseStatelessWidget({Key? key, required this.cubit}) : super(key: key);
}