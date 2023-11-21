import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:preto3/components/dotted_container.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_string.dart';

class DailyActivitySetTime extends StatelessWidget {
  DailyActivitySetTime({Key? key}) : super(key: key);

  final dailyController = Get.find<DailyActivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 8, right: 8, top: 8),
        child: InkWell(
          onTap: () {
            _bottomUploadImageSheet(context);
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            color: AppColor.appPrimary,
            child: Container(
                height: 120,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.dashRoomBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.uploadFileIcon),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 5),
                        child: Text(
                          "Add file",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        "Please upload a image with maximum file size of 2 MB.",
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
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
          AppString.addActivity,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                dailyController.saveSession(context);
              },
              child: Center(
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.students,
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Stack(
                      children: [
                        for (int i = 0;
                            i < dailyController.profilePicImageList.length;
                            i++)
                          Positioned(
                            top: 5,
                            left: 30 * i.toDouble(),
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(42)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => const Image(
                                    height: 42,
                                    width: 42,
                                    image: AssetImage(
                                      AppAssets.placeHolder,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl:
                                      dailyController.profilePicImageList[i],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Image(
                                    height: 42,
                                    width: 42,
                                    image: AssetImage(
                                      AppAssets.placeHolder,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(AppAssets.editIcon))
                ],
              ),
              InkWell(
                onTap: () {
                  dailyController.addStartDate(context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  height: 42,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SvgPicture.asset(AppAssets.calenderIcon),
                      ),
                      Obx(() => dailyController.selectedAddStartDate.isNotEmpty
                          ? Text(
                              dailyController.selectedAddStartDate.toString(),
                              style: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            )
                          : Text(
                              "Start Date",
                              style: GoogleFonts.poppins(
                                  color: AppColor.lightTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ))
                    ],
                  ),
                ),
              ),
              GetBuilder<DailyActivityController>(
                builder: (controller) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.activityDetailList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(42),
                                        border: Border.all(
                                            color: AppColor.borderColor,
                                            width: 1)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const Image(
                                          height: 42,
                                          width: 42,
                                          image: AssetImage(
                                            AppAssets.placeHolder,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        imageUrl:
                                            controller.activityImage[index],
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            const Image(
                                          height: 42,
                                          width: 42,
                                          image: AssetImage(
                                            AppAssets.placeHolder,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      controller.activityDetailList[index]
                                          .description,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.mediumTextColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  controller.removeFromList(index);
                                  controller.update();
                                },
                                child: Text(
                                  "Remove",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.invoiceNumberColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.pickStartTime(context, index);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start Time",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 42,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          color: AppColor.disableColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: SvgPicture.asset(
                                                AppAssets.clockIcon),
                                          ),
                                          Text(
                                            controller.activityDetailList[index]
                                                    .selectedStartTime ??
                                                "Start Time",
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.pickEndTime(context, index);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "End Time",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 42,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          color: AppColor.disableColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: SvgPicture.asset(
                                                AppAssets.clockIcon),
                                          ),
                                          Text(
                                            controller.activityDetailList[index]
                                                    .selectedEndTime ??
                                                "End Time",
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Description",
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Form(
                              child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: AppColor.appPrimary,
                            style: GoogleFonts.poppins(
                                color: AppColor.hintTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              hintText: "Description",
                              helperStyle: GoogleFonts.poppins(
                                  color: AppColor.heavyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.borderColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.appPrimary),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            // controller: loginController.emailController,
                            onSaved: (savedValue) {
                              // loginController.emailController.text = savedValue!;
                              // loginController.email.value = savedValue!;
                            },
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    }),
              ),
              Obx(
                () => dailyController.selectedImagePath.value != ""
                    ? Column(
                        children: [
                          Container(
                            height: 25,
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                dailyController.selectedImagePath.value = "";
                                dailyController.selectedFileName.value = "";
                              },
                              child:
                                  SvgPicture.asset(AppAssets.closeFilterIcon),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              image: AssetImage(
                                dailyController.selectedImagePath.value,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _bottomUploadImageSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setter) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: AppColor.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              dailyController.getImage(ImageSource.camera);
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(4, 4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.white12,
                                        offset: Offset(-4, -4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                  ]),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      color: AppColor.appPrimary,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(
                                          color: AppColor.appPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              dailyController.getImage(ImageSource.gallery);
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(4, 4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.white12,
                                        offset: Offset(-4, -4),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                  ]),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.image_outlined,
                                      color: AppColor.appPrimary,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                          color: AppColor.appPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ));
          });
        });
  }
}
