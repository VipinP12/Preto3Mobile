import 'dart:ui';

class AppColor{
  AppColor._();
  static const appPrimary = Color(0xFFB01AA7);
  static const appSecondary = Color(0xFFED89FF);
  static const accentColor = Color(0xFFED89FF);
  static const scaffoldBackground = Color(0xFFFFFFFF);
  static const heavyTextColor = Color(0xFF4D4C4C);
  static const mediumTextColor = Color(0xFF656565);
  static const lightTextColor = Color(0xFFA8A8A8);
  static const disableColor = Color(0xFFF0F0F0);
  static const hintTextColor = Color(0xFF828EA3);
  static const editProfile = Color(0xFF4285F4);
  static const invoiceNumberColor = Color(0xFF5463D6);
  static const disableTextColor=Color(0xFFC7C7C7);

  static const totalColor = Color(0xFF0EAAF4);
  static const inColor = Color(0xFF9AA720);
  static const outColor = Color(0xFFEF9438);
  static const absentColor = Color(0xFFE53A24);

  static const borderColor=Color(0xFFD9D9D9);
  static const white=Color(0xFFFFFFFF);
  static const black=Color(0xFF000000);
  static const allergiesText=Color(0xFF008080);
  static const allergiesBg=Color(0x26008080);

  //DASHBOARD
  static const dashRoomBg = Color(0x26B01AA7);
  static const childfeesBg = Color(0x0DB01AA7);
  static const dashCheckInBg = Color(0x26EF9438);
  static const dashCommBg = Color(0x26EA706F);
  static const dashFeesBg = Color(0x260EAAF4);
  static const dashSchoolSettingBg = Color(0x26EF9438);
  static const dashStaffScheduleBg = Color(0x2662C4B5);

  static const dashRoomText=Color(0xFFB01AA7);
  static const dashCheckInText=Color(0xFFEF9438);
  static const dashCommText=Color(0xFFEA706F);
  static const dashFeesText=Color(0xFF0EAAF4);
  static const dashSchoolSettingText=Color(0xFFEF9438);
  static const dashStaffScheduleText=Color(0xFF62C4B5);

  //ROOM
  static const roomColor1=Color(0xFF479D3E);
  static const roomColor2=Color(0xFFB01AA7);
  static const roomColor3=Color(0xFFC59548);
  static const roomColor4=Color(0xFF5ECBDD);

  //PROFILE
  static const profileHeaderBG=Color(0x15B01AA7);

  //Invoice
  static const paidColor = Color(0xFF2DC071);
  static const declinedColor = Color(0xFFE53C26);
  static const inProgressColor = Color(0xFFFE8934);
  static const invoiceFilterColor = {
    "Unpaid": lightTextColor,
    "Inprogress": inProgressColor,
    "Paid": paidColor,
    "Declined": declinedColor,
    "Refund": paidColor
  };
  static const dashCardIcon = Color(0x40000000);

  static const afternoon = Color(0xFF81AC4E);
  static const evening = Color(0xFFB01AA7);
  static const outdoor = Color(0xFFED6923);
  static const lunch = Color(0xFF0096C9);
  static const nap = Color(0xFF0096C9);
  static const acceptBg = Color(0x0D5463D6);
  static const declineBg = Color(0x0DE53C26);
  static const maybeBg = Color(0x0D2DC071);

}