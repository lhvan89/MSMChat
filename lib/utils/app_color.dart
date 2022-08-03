import 'package:flutter/material.dart';

extension AppColor on Color {
  static Color fromHex(String strHex) {
    strHex = strHex.replaceAll("#", "");
    if (strHex.length == 6) {
      return Color(int.parse("0xFF" + strHex));
    } else if (strHex.length == 8) {
      return Color(int.parse("0x" + strHex));
    } else {
      return Colors.black;
    }
  }

  //Define color for app
  static const Color avatarColor = Color(0xFFF4AE22);
  static const Color primaryColor = Color(0xFF004F7C);
  static const Color primaryLightColor = Color(0xFFE1EDF9);
  static const Color secondaryColor = Color(0xffdce6c8);
  static const Color backgroundColor = Color(0xFFF2F3F2);
  static const Color buttonColor = Color(0xFF004F7C);
  static const Color deleteColor = Color(0xffF01010);

  static const Color cancelColor = Color(0xFF989898);
  static const Color closeColor = Color(0xFF9c9c9c);
  static const Color calendarEventColor = Color(0xFFD8EDFC);
  static const Color calendarEventPastColor = Color(0xFFeaeaea);
  static const Color primaryDarkColor = Color(0xFF2C7438);
  static const Color bgGreyColor = Color(0xFFe6e2dd);
  static const Color blackTextColor = Color(0xFF313131);
  static const Color placeholderTextColor = Color(0xFFb9b9b9);
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF6F6F6F);
  static const Color tertiaryTextColor = Color(0xFF717171);
  static const Color titleTextColor = Color(0xFF00548E);
  static const Color disableColor = Color(0xFFD5D5D9);
  static const Color disableFieldColor = Color(0xFFF3F3F3);
  static const Color dividerColor = Color(0xFFE1E1E1);
  static const Color borderGreyColor = Color(0xFFb7b7b7);
  static const Color headerBackgroundColor = Color(0xFFd1d1d1);
  static const Color sdtcEndColor = Color(0xFFFAAD44);
  static const Color sdtcItemColor = Color(0xFF2677B9);
  static const Color sdtcSubItemColor = Color(0xFFA1A1A1);
  static const Color offItemColor = Color(0xFFE8F9FD);
  static const Color sdtcStartColor = Color(0xFFFF6B01);
  static const Color redColor = Colors.redAccent;
  static const Color whiteColor = Colors.white;
  static const Color bgDayOffColor = Color(0xFF11B929);
  static const Color bgDayOffProgress = Color(0xFFb09428);
  static const Color tabColor = Colors.white;
  static const Color tabbarItemColor = Colors.white70;
  static const Color darkPrimaryColor = Color(0xFF002e51);

  //Trình ký
  static const Color greenActiveColor = Color(0xFF69c36d); //Màu xanh active
  static const Color grayInActiveColor = Color(0xFFd2d2d2); //Màu xám inactive
  static const Color orangeCurrentStepColor =
  Color(0xFFff7c2a); //Màu cam lưu đồ đang xử lý
  static const Color graySmallTextColor =
  Color(0xFFb3b3b3); //Màu xám cho text nhỏ
  static const Color grayHeaderTitleList = Color(
      0xFF878787); //Màu xám của text bên trên list item (Ex: chờ tôi xử lý,...)

  static const LinearGradient defaultAppbarGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF002e51),
      Color(0xFF004c85),
      Color(0xFF006ea5),
    ],
  );

  static const LinearGradient defaultOrangeGradient =
  LinearGradient(colors: [Color(0xFFfa4a1f), Color(0xfff8b530)]);

  static const LinearGradient buttonLoginGradient =
  LinearGradient(colors: [primaryColor, sdtcItemColor]);

  static const LinearGradient progressGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        bgDayOffColor,
        bgDayOffColor,
        bgDayOffColor,
        bgDayOffProgress,
        bgDayOffProgress
      ]);

  static const boxShadowDefault = [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0.0, 3.0),
      blurRadius: 8,
    )
  ];
  static const buttonBoxShadow = [
    BoxShadow(
      color: primaryColor,
      offset: Offset(0.0, 2.0),
      blurRadius: 4,
    )
  ];

  static var buttonBoxShadow2 = [
    BoxShadow(
      color: sdtcItemColor.withOpacity(0.7),
      offset: Offset(0.0, 2.0),
      blurRadius: 8,
    )
  ];

  static var shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
