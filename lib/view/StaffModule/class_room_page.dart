import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Staff/class_room_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';

class ClassRoomPage extends StatelessWidget {
  ClassRoomPage({Key? key}) : super(key: key);

  final classController = Get.find<ClassRoomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          AppString.room,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: const [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 4.0),
          //   child: Icon(
          //     Icons.search,
          //     color: Colors.white,
          //     size: 24,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
      body: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Text(
                  "Students",
                  style: GoogleFonts.poppins(
                      color: AppColor.appPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              classController.notContentFound.isTrue
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: SvgPicture.asset(AppAssets.notFoundIcon)),
                          const SizedBox(
                            height: AppDimens.paddingVertical16,
                          ),
                          Text(
                            "No content found",
                            style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: GetBuilder<ClassRoomController>(
                      builder: ((controller) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListView.separated(
                              itemCount: controller.allRoomList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoute.studentProfileDetails,
                                        arguments: {
                                          ArgumentKeys.argumentStudentId:
                                              controller.allRoomList[index].id,
                                          ArgumentKeys.argumentChildFirstName:
                                              controller
                                                  .allRoomList[index].firstName,
                                          ArgumentKeys.argumentChildLastName:
                                              controller
                                                  .allRoomList[index].lastName,
                                        });
                                  },
                                  child: SizedBox(
                                    height: 80,
                                    width: double.maxFinite,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 42,
                                                width: 42,
                                                decoration: BoxDecoration(
                                                    color: AppColor.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    placeholder:
                                                        (context, url) =>
                                                            const Image(
                                                      height: 50,
                                                      width: 50,
                                                      image: AssetImage(
                                                        AppAssets.placeHolder,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    imageUrl:
                                                        '${controller.allRoomList[index].profilePic}',
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Image(
                                                      height: 50,
                                                      width: 50,
                                                      image: AssetImage(
                                                        AppAssets.placeHolder,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 26,
                                                  left: 26,
                                                  right: 0,
                                                  bottom: 0,
                                                  child: SvgPicture.asset(
                                                    controller
                                                                .allRoomList[
                                                                    index]
                                                                .status ==
                                                            "Checked in"
                                                        ? AppAssets.activeIcon
                                                        : controller
                                                                    .allRoomList[
                                                                        index]
                                                                    .status ==
                                                                "Absent"
                                                            ? AppAssets
                                                                .absentIcon
                                                            : AppAssets
                                                                .inActiveIcon,
                                                    height: 16,
                                                    width: 16,
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Flexible(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${controller.allRoomList[index].firstName.toString()} ${controller.allRoomList[index].lastName.toString()}",
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppColor.heavyTextColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Get.toNamed(AppRoute
                                                        .studentProfile);
                                                  },
                                                  child: SvgPicture.asset(
                                                    AppAssets.editProfileIcon,
                                                    color: AppColor
                                                        .mediumTextColor,
                                                    height: 20,
                                                    width: 20,
                                                  ))
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  color: Colors.grey,
                                  thickness: 0.6,
                                );
                              },
                            ),
                          )),
                    ))
            ],
          )),
    );
  }
}
