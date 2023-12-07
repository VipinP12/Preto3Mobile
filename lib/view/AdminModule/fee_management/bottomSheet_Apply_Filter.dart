import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/comman_textStyle.dart';
import '../../../../components/rounded_button.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';

class FilterApplyBottomSheet extends StatelessWidget {
  const FilterApplyBottomSheet({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            // eventController.roleId.value == 4
            //     ? MediaQuery.of(context).size.height * 0.6
            //     : MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5)),
            ),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 54,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: AppColor.appPrimary,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              )),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Apply Filter",
                                style:TextStyles.textStyleFW500(AppColor.white,16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    // eventController.pickStartDate(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    width: double.maxFinite,
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
                                              AppAssets.calenderIcon),
                                        ),
                                        // Obx(() => eventController
                                        //     .filteredStartDate.isNotEmpty
                                        //     ? Text(
                                        //   eventController
                                        //       .filteredStartDate
                                        //       .toString(),
                                        //   style: GoogleFonts.poppins(
                                        //       color: AppColor
                                        //           .heavyTextColor,
                                        //       fontSize: 14,
                                        //       fontWeight:
                                        //       FontWeight.w400),
                                        // )
                                        //     :

                                        Text(
                                          "Start Date",
                                          style: TextStyles.textStyleFW400(AppColor.black,14),
                                        )
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    // eventController.pickEndDate(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    width: double.maxFinite,
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
                                              AppAssets.calenderIcon),
                                        ),
                                        // Obx(() => eventController
                                        //     .filteredEndDate.isNotEmpty
                                        //     ? Text(
                                        //   eventController
                                        //       .filteredEndDate
                                        //       .toString(),
                                        //   style: GoogleFonts.poppins(
                                        //       color: AppColor
                                        //           .heavyTextColor,
                                        //       fontSize: 14,
                                        //       fontWeight:
                                        //       FontWeight.w400),
                                        // )
                                        //     :
                                        Text(
                                          "End Date",
                                          style: TextStyles.textStyleFW400(AppColor.black,14),
                                        )
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 45,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: AppColor.disableColor,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                        height: 45,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: AppColor.disableColor,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Select School"),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        )
                                      // GetBuilder<StudentController>(builder: (controller) =>
                                      //     Padding(
                                      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      //       child: DropdownButton<RoomListModel>(
                                      //         //elevation: 5,
                                      //         hint: Align(
                                      //           alignment: Alignment.centerLeft,
                                      //           child: Text('Select Room',style: GoogleFonts.poppins(
                                      //               color: AppColor.lightTextColor,
                                      //               fontSize: 14,
                                      //               fontWeight: FontWeight.w400
                                      //           ),),
                                      //         ),
                                      //         isExpanded: true,
                                      //         icon: Visibility(
                                      //             visible: true,
                                      //             child: SvgPicture.asset(AppAssets.dropdownIcon)),
                                      //         dropdownColor: AppColor.white,
                                      //         borderRadius: BorderRadius.circular(10),
                                      //         iconEnabledColor: AppColor.appPrimary,
                                      //         underline: Container(),
                                      //         alignment: Alignment.topCenter,
                                      //         items: controller.allRoomList.map((
                                      //             RoomListModel? room) =>
                                      //             DropdownMenuItem<RoomListModel>(
                                      //                 value: room, child: Text(room!.className.toString(),style: GoogleFonts.poppins(
                                      //                 color: AppColor.heavyTextColor,
                                      //                 fontSize: 14,
                                      //                 fontWeight: FontWeight.w400
                                      //             ),)))
                                      //             .toList(),
                                      //         onChanged: (changed){
                                      //           controller.setRoom(changed!);
                                      //           log("Selected Room:${controller.selectedClassRoom}");
                                      //         },
                                      //         value: controller.myRoom,
                                      //       ),
                                      //     ),
                                      // )
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 45,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: AppColor.disableColor,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                        height: 45,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: AppColor.disableColor,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Select School"),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0,bottom: 20),
                                child: RoundedButton(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColor.appPrimary,
                                    onClick: () {
                                      Get.back();
                                      // eventController.filteredDate.value =
                                      // true;
                                      // eventController.filterEvent(
                                      //     eventController.startEpoch.value,
                                      //     eventController.endEpoch.value);
                                    },
                                    text: 'Apply',
                                    style: TextStyles.textStyleFW400(AppColor.white,16)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(AppAssets.closeFilterIcon)),
                )
              ],
            ))
      ],
    );
  }
}
