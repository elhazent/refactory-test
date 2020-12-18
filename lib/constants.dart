import 'package:flutter/material.dart';

class DefaultKey{
  static const AccessToken = "TOKEN";
  static const DBName = "refactoryDb";
  static const TableName = "login_story";
  static const EmailColumn = "email";
  static const PathImageColumn = "pathImage";
  static const PasswordColumn = "password";
  static const TotalLoginColumn = "totalLogin";
  static const TotalRegisterColumn = "totalRegister";

}

class DefaultModul{
  static const Auth = "auth";
}

class DefaultColor{
  static final textPrimary = Color(0xff333333);
  static final primaryColor = Color(0xff007cba);
  static final secondaryColor = Color(0xffC1B265);
  static final background = Colors.grey.shade200;
  static final textField = Color(0xFFDDDDDD).withOpacity(0.5);

}

class DefaultDimen {
  static double spaceDoubleExtraLarge = 64.0;
  static double spaceExtraLarge = 32.0;
  static const double spaceMidLarge = 24.0;
  static double spaceLarge = 16.0;
  static double spaceMedium = 12.0;
  static double spaceSmall = 8.0;
  static double spaceTiny = 4.0;

  static double textDoubleExtraLarge = 48.0;
  static double textExtraLarge = 20.0;
  static double textLarge = 18.0;
  static double textMedium = 14.0;
  static double textRegular = 12.0;
  static double textSmall = 11.0;
  static double textTiny = 8.0;

  static double buttonTiny = 24.0;
  static double buttonSmall = 32.0;
  static double buttonRegular = 48.0;
  static double buttonMedium = 56.0;

  static double radius = 4.0;
  static double ratioThumbnail = 16 / 9;
  static double ratioBanner = 5 / 2;
  static double ratioSquare = 1;

  static double iconTiny = 12;
  static double iconSmall = 16;
  static double iconRegular = 24;
  static double iconLarge = 32;

  static double avatarLarge = 96;
  static double avatarRegular = 48;
  static double avatarSmall = 32;
  static double avatarTiny = 24;

}

class DefaultFontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class DefaultImageLocation {
  static const String RefactoryLogo = 'assets/images/refactorylogo.png';
  static const String HomeBg = 'assets/images/homebg.jpg';
  static const String Stronger = 'assets/images/stronger.png';
  static const String Power = 'assets/images/power.png';
  static const String CourseBg = 'assets/images/coursebg.jpeg';


}

class DefaultFont {
  static const String PoppinsFont = 'Poppins';
}