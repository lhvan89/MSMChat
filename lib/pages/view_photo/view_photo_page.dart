import 'package:msmchat/pages/view_photo/view_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/utils/app_color.dart';
import 'package:photo_view/photo_view.dart';
import '../base_staless_widget.dart';

class ViewPhotoPage extends BaseStatelessWidget<ViewPhotoCubit> {
  String urlPhoto = '';
  ViewPhotoPage({Key? key, required this.urlPhoto}) : super(key: key, cubit: ViewPhotoCubit());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('PHOTO VIEWER'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: Image.network(urlPhoto).image,
        ),
      ),
    );
  }
}
