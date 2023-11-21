import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/components/rounded_button.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/toast.dart';

class CreateStaffGroup extends StatelessWidget {
  CreateStaffGroup({Key? key}) : super(key: key);

  final parentController = Get.find<ParentDashboardController>();
  final communicationController = Get.find<CommunicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColor.appPrimary,
          leading: InkWell(
            onTap: () => Get.back(result: false),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          centerTitle: false,
          title: Text(
            AppString.messageToStaff,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 45,
                //   width: double.maxFinite,
                //   decoration: BoxDecoration(
                //       color: AppColor.disableColor,
                //       borderRadius: BorderRadius.circular(10)),
                //   child: TextFormField(
                //     keyboardType: TextInputType.text,
                //     textInputAction: TextInputAction.next,
                //     cursorColor: AppColor.appPrimary,
                //     style: GoogleFonts.poppins(
                //         color: AppColor.hintTextColor,
                //         fontSize: 14,
                //         fontWeight: FontWeight.w400),
                //     onEditingComplete: () => FocusScope.of(context).unfocus(),
                //     decoration: InputDecoration(
                //       hintText: "search staff",
                //       helperStyle: GoogleFonts.poppins(
                //           color: AppColor.lightTextColor,
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: const BorderSide(color: AppColor.borderColor),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         borderSide: const BorderSide(color: AppColor.appPrimary),
                //       ),
                //       prefixIcon: SvgPicture.asset(
                //         AppAssets.searchIconGrey,
                //         height: 30,
                //         width: 30,
                //         fit: BoxFit.scaleDown,
                //       ),
                //       contentPadding: EdgeInsets.zero,
                //       filled: true,
                //       fillColor: AppColor.disableColor,
                //     ),
                //     controller: parentController.searchStaffController,
                //     onChanged: (savedValue) {
                //       parentController.searchStaff.value = savedValue;
                //     },
                //   ),
                // ),

                // const SizedBox(
                //   height: 10,
                // ),
                parentController.childDetailsList.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Children",
                          style: GoogleFonts.poppins(
                              color: AppColor.appPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ))
                    : const SizedBox.shrink(),
                parentController.childDetailsList.isNotEmpty
                    ? const SizedBox(
                        height: AppDimens.paddingVertical16,
                      )
                    : const SizedBox.shrink(),
                parentController.childDetailsList.isNotEmpty
                    ? GetBuilder<ParentDashboardController>(
                        builder: (controller) => GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 20),
                            itemCount: controller.childDetailsList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 4),
                                child: InkWell(
                                  onTap: () {
                                    controller.changeChildIndex(index);
                                    controller.selectedChildIndex == index;
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 6.0,
                                                    spreadRadius: 2.0,
                                                    offset: Offset(0.0, 0.0))
                                              ]),
                                          child: controller
                                                      .selectedChildIndex ==
                                                  index
                                              ? Stack(
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          color: AppColor.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      60)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        child:
                                                            CachedNetworkImage(
                                                          placeholder:
                                                              (context, url) =>
                                                                  const Image(
                                                            height: 60,
                                                            width: 60,
                                                            image: AssetImage(
                                                              AppAssets
                                                                  .placeHolder,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          imageUrl:
                                                              '${controller.childDetailsList[index].profilePic}',
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Image(
                                                            height: 60,
                                                            width: 60,
                                                            image: AssetImage(
                                                              AppAssets
                                                                  .placeHolder,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SvgPicture.asset(AppAssets
                                                        .checkInSelectedIcon)
                                                  ],
                                                )
                                              : const Image(
                                                  image: AssetImage(
                                                      AppAssets.placeHolder),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 4),
                                          child: Center(
                                            child: Text(
                                              '${controller.childDetailsList[index].firstName.toString()} ${controller.childDetailsList[index].lastName.toString()} ',
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
                    : const SizedBox.shrink(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Staff",
                      style: GoogleFonts.poppins(
                          color: AppColor.appPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    )),
                const SizedBox(
                  height: AppDimens.paddingVertical16,
                ),
                GetBuilder<ParentDashboardController>(
                  builder: (controller) => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 20),
                      itemCount: controller.allStaff.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 4),
                          child: InkWell(
                            onTap: () {
                              controller.changeIndex(index);
                              controller.selectedIndex == index;
                              communicationController.selectedStaffId.value =
                                  controller.allStaff[index]!.staffId;
                            },
                            child: Container(
                              height: 120,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(60),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 6.0,
                                              spreadRadius: 2.0,
                                              offset: Offset(0.0, 0.0))
                                        ]),
                                    child: controller.selectedIndex == index
                                        ? Stack(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: AppColor.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: CachedNetworkImage(
                                                    placeholder:
                                                        (context, url) =>
                                                            const Image(
                                                      height: 60,
                                                      width: 60,
                                                      image: AssetImage(
                                                        AppAssets.placeHolder,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    imageUrl:
                                                        '${controller.allStaff[index]!.profilePic}',
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Image(
                                                      height: 60,
                                                      width: 60,
                                                      image: AssetImage(
                                                        AppAssets.placeHolder,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                  AppAssets.checkInSelectedIcon)
                                            ],
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const Image(
                                                height: 60,
                                                width: 60,
                                                image: AssetImage(
                                                  AppAssets.placeHolder,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              imageUrl:
                                                  '${controller.allStaff[index]!.profilePic}',
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Image(
                                                height: 60,
                                                width: 60,
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
                                        vertical: 0.0, horizontal: 4),
                                    child: Center(
                                      child: Text(
                                        '${controller.allStaff[index]!.firstName.toString()} ${controller.allStaff[index]!.lastName.toString()} ',
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
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
          child: RoundedButton(
              height: 50,
              width: 320,
              color: AppColor.appPrimary,
              onClick: () async {
                if (parentController.selectedChildIndex == -1 &&
                    parentController.selectedIndex == -1) {
                  messageToastWarning(
                      context, "Please select a staff and parent.");
                } else if (parentController.selectedChildIndex == -1) {
                  messageToastWarning(context, "Please select a child.");
                } else if (parentController.selectedIndex == -1) {
                  messageToastWarning(context,
                      "Please select a staff. If staff is not available, you will not be able to communicate.");
                } else {
                  if (await communicationController.createNewGroup()) {
                    Get.back(result: true);
                  }
                }
              },
              text: 'Next',
              style: GoogleFonts.poppins(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ));
  }
}
