import 'package:msmchat/cubit/base_cubit.dart';
import 'package:msmchat/models/user_model.dart';

class ProfileCubit extends BaseCubit {
  final UserModel currentUser;

  ProfileCubit({required this.currentUser});

  @override
  void initCubit() {
    super.initCubit();
  }

  @override
  void dispose() {
    super.dispose();
  }

}