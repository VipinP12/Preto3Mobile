import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/scanner_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/toast.dart';

class CheckInOutPage extends StatelessWidget {
  CheckInOutPage({Key? key}) : super(key: key);

  final scannerController = Get.find<ScannerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: false,
        title: Text(
          AppString.selectChildren,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: scannerController.childrenList.isNotEmpty
                ? GetBuilder<ScannerController>(
                    builder: (controller) => GridView.builder(
                        padding: const EdgeInsets.only(bottom: 60),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 20),
                        itemCount: controller.childrenList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                controller.childrenList[index].isSelected =
                                    !controller.childrenList[index].isSelected;
                                controller.setIdList(index);

                                controller.update();
                              },
                              child: Container(
                                height: 120,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(65),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6.0,
                                                spreadRadius: 2.0,
                                                offset: Offset(0.0, 0.0))
                                          ]),
                                      child: controller
                                              .childrenList[index].isSelected
                                          ? Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      const Image(
                                                    height: 75,
                                                    width: 75,
                                                    image: AssetImage(
                                                      AppAssets.placeHolder,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  imageUrl: controller
                                                      .childrenList[index]
                                                      .userProfilePic,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Image(
                                                    height: 75,
                                                    width: 75,
                                                    image: AssetImage(
                                                      AppAssets.placeHolder,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SvgPicture.asset(AppAssets
                                                    .checkInSelectedIcon),
                                              ],
                                            )
                                          : Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      const Image(
                                                    height: 75,
                                                    width: 75,
                                                    image: AssetImage(
                                                      AppAssets.placeHolder,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  imageUrl: controller
                                                      .childrenList[index]
                                                      .userProfilePic,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Image(
                                                    height: 75,
                                                    width: 75,
                                                    image: AssetImage(
                                                      AppAssets.placeHolder,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 4),
                                      child: Center(
                                        child: Text(
                                          '${controller.childrenList[index].firstName.toString()} ${controller.childrenList[index].lastName.toString()} ',
                                          style: GoogleFonts.poppins(
                                              color: AppColor.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : GetBuilder<ScannerController>(
                    builder: (controller) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: controller.studentList
                                .asMap()
                                .entries
                                .map(
                                  (element) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.studentList[element.key]
                                                .checkedInOutStatus ==
                                            "Checked-Out") {
                                          return;
                                        }
                                        controller.studentList[element.key]
                                                .isSelected =
                                            !controller.studentList[element.key]
                                                .isSelected;
                                        controller.setIdList(element.key);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 65,
                                              width: 65,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          65)),
                                              child:
                                                  controller
                                                          .studentList[
                                                              element.key]
                                                          .isSelected
                                                      ? Stack(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          65),
                                                              child:
                                                                  CachedNetworkImage(
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const Image(
                                                                  height: 65,
                                                                  width: 65,
                                                                  image:
                                                                      AssetImage(
                                                                    AppAssets
                                                                        .placeHolder,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                height: 65,
                                                                width: 65,
                                                                imageUrl: controller
                                                                    .studentList[
                                                                        element
                                                                            .key]
                                                                    .profilePic,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Image(
                                                                  height: 65,
                                                                  width: 65,
                                                                  image:
                                                                      AssetImage(
                                                                    AppAssets
                                                                        .placeHolder,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            SvgPicture.asset(
                                                                AppAssets
                                                                    .checkInSelectedIcon),
                                                            Positioned(
                                                                bottom: 0,
                                                                right: 0,
                                                                child:
                                                                    Container(
                                                                  height: 15,
                                                                  width: 15,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      color: controller.studentList[element.key].checkedInOutStatus == "Checked-In"
                                                                          ? Colors.green
                                                                          : controller.studentList[element.key].checkedInOutStatus == "Absent"
                                                                              ? Colors.red
                                                                              : Colors.grey,
                                                                      //color: Colors.green,
                                                                      border: Border.all(color: AppColor.white, width: 1.5)),
                                                                )),
                                                          ],
                                                        )
                                                      : Stack(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          65),
                                                              child:
                                                                  CachedNetworkImage(
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const Image(
                                                                  height: 65,
                                                                  width: 65,
                                                                  image:
                                                                      AssetImage(
                                                                    AppAssets
                                                                        .placeHolder,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                height: 65,
                                                                width: 65,
                                                                imageUrl: controller
                                                                    .studentList[
                                                                        element
                                                                            .key]
                                                                    .profilePic,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Image(
                                                                  height: 65,
                                                                  width: 65,
                                                                  image:
                                                                      AssetImage(
                                                                    AppAssets
                                                                        .placeHolder,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                bottom: 0,
                                                                right: 0,
                                                                child:
                                                                    Container(
                                                                  height: 15,
                                                                  width: 15,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      color: controller.studentList[element.key].checkedInOutStatus == "Checked-In"
                                                                          ? Colors.green
                                                                          : controller.studentList[element.key].checkedInOutStatus == "Absent"
                                                                              ? Colors.red
                                                                              : Colors.grey,
                                                                      //color: Colors.green,
                                                                      border: Border.all(color: AppColor.white, width: 1.5)),
                                                                )),
                                                          ],
                                                        )),
                                          Text(
                                            "${element.value.firstName} ${element.value.lastName}",
                                            style: GoogleFonts.poppins(
                                                color: AppColor.heavyTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 42),
            child: RoundedButton(
              height: 42,
              width: double.maxFinite,
              color: AppColor.appPrimary,
              text: 'Submit',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              onClick: () {
                if (scannerController.idList.isNotEmpty) {
                  scannerController.checkInMultiPerson(context);
                } else {
                  messageToastWarning(context,
                      "Please select a student or child. If you have already checked out all students or children, you can not checked in again.");
                  //scannerController.checkInMultiPerson(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
