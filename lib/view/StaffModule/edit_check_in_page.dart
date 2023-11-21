import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Staff/edit_checkin_controller.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_string.dart';

class EditCheckInPage extends StatelessWidget {
  EditCheckInPage({Key? key}) : super(key: key);

  final editCheckInController = Get.find<EditCheckInController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          AppString.editCheckIn,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: (){
              editCheckInController.editCheckInSession();
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  AppString.save,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Obx(() => Text(
                      editCheckInController.selectedDate.value,
                      style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
              height: 65,width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(65),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                    const Image(
                      height: 65,
                      width: 65,
                      image: AssetImage(
                        AppAssets.placeHolder,
                      ),
                      fit: BoxFit.cover,
                    ),
                    imageUrl:
                    editCheckInController.profilePic.value,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                    const Image(
                      height: 65,
                      width: 65,
                      image: AssetImage(
                        AppAssets.placeHolder,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),)),
                      Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15),
                                color: editCheckInController
                                    .status.value ==
                                    "Checked in"
                                    ? Colors.green
                                    : editCheckInController
                                    .status.value ==
                                    "Checked out"
                                    ? Colors.grey
                                    : Colors.red,
                                border: Border.all(
                                    color: AppColor.white,
                                    width: 1.5)),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text("${editCheckInController.first.value} ${editCheckInController.last.value}",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(editCheckInController.classRoom.value,
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
              child: SizedBox(
                height: 45,width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("In time",style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("   -",style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),),
                    ),
                    Flexible(
                      child:InkWell(
                        onTap: (){
                          editCheckInController.pickInTime(context);
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppAssets.clockIcon),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Obx(()=>Text(editCheckInController.selectedInTime.value,style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
              child: SizedBox(
                height: 45,width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Out time",style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0),
                      child: Text("-",style: GoogleFonts.poppins(
                          color: AppColor.heavyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),),
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: (){
                          editCheckInController.pickOutTime(context);
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppAssets.clockIcon),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Obx(()=>Text(editCheckInController.selectedOutTime.value,style: GoogleFonts.poppins(
                                      color: AppColor.heavyTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Remarks",style: GoogleFonts.poppins(
                  color: AppColor.heavyTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
            ),
            Form(
              key: editCheckInController.remarkKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: AppColor.appPrimary,
                // focusNode:signUpController.emailFocusNode,
                // onTap: (){
                //   signUpController.focusEmailIcons(true);
                // },
                style: GoogleFonts.poppins(
                    color: AppColor.hintTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                onEditingComplete: () => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: "Remark",
                  helperStyle: GoogleFonts.poppins(
                      color: AppColor.hintTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.hintTextColor),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.appPrimary),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.white,
                ),
                controller: editCheckInController.remarkController.value,
                onSaved: (savedValue) {
                  editCheckInController.remark.value = savedValue!;
                },
                validator: (valid) {
                  return editCheckInController
                      .remarkValidator(valid.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
