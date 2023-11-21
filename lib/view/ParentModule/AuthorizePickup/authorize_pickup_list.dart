import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'package:preto3/utils/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controller/Parent/AuthorizePickup/authorize_pickup_controller.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_routes.dart';

class AuthorizePikupList extends StatelessWidget {
  AuthorizePikupList({super.key});

  final authorizePikupController = Get.find<AuthorizePikupController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColor.appPrimary,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back),
          ),
          centerTitle: false,
          title: Text(
            "Authorize Pickup",
            style: GoogleFonts.poppins(
                color: AppColor.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            InkWell(
              onTap: () async {
                if (await Get.toNamed(AppRoute.authorizePickupCreate)) {
                  authorizePikupController.getListOfAuthorizePickup(
                      authorizePikupController.url.value);
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                child: Text("+",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isDismissible: true,
                  enableDrag: false,
                  builder: (context) {
                    return Wrap(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                  AppAssets.bottomBarCloseIcon)),
                        ),
                        Container(
                          color: AppColor.white,
                          padding: const EdgeInsets.only(bottom: 70),
                          child: Column(children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.appPrimary,
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Text("Apply Filter",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      margin: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                authorizePikupController
                                                    .setPickStartDate(
                                                        await authorizePikupController
                                                            .pickDate(context));
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          left: 10,
                                                          right: 30),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_month_rounded,
                                                        size: 25,
                                                        color: AppColor.black,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Obx(
                                                          () => Text(
                                                            authorizePikupController
                                                                    .filterStartDate
                                                                    .trim()
                                                                    .isEmpty
                                                                ? "Start date"
                                                                : authorizePikupController
                                                                    .filterStartDate
                                                                    .value,
                                                            style: GoogleFonts.poppins(
                                                                color: AppColor
                                                                    .lightTextColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                authorizePikupController
                                                    .setPickEndDate(
                                                        await authorizePikupController
                                                            .pickDate(context));
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          left: 10,
                                                          right: 30),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_month_rounded,
                                                        size: 25,
                                                        color: AppColor.black,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Obx(
                                                          () => Text(
                                                            authorizePikupController
                                                                    .filterEndDate
                                                                    .trim()
                                                                    .isEmpty
                                                                ? "End date"
                                                                : authorizePikupController
                                                                    .filterEndDate
                                                                    .value,
                                                            style: GoogleFonts.poppins(
                                                                color: AppColor
                                                                    .lightTextColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                if (authorizePikupController
                                    .filterStartDate.value
                                    .trim()
                                    .isEmpty) {
                                  messageToastWarning(
                                      context, "Start date cannot be empty");
                                } else if (authorizePikupController
                                        .filterEndDate.value
                                        .trim()
                                        .isEmpty ||
                                    authorizePikupController.dateDifference()) {
                                  Navigator.pop(context);
                                  authorizePikupController.applyFilter();
                                  // authorizePikupController
                                  //     .filterStartDate.value = "";
                                  // authorizePikupController.filterEndDate.value =
                                  //     "";
                                } else {
                                  messageToastWarning(context,
                                      "Start date cannot be after the end date");
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.appPrimary,
                                ),
                                child: Text("Apply",
                                    style: GoogleFonts.poppins(
                                        color: AppColor.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ),
                            )
                          ]),
                        )
                      ],
                    );
                  },
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                child: SvgPicture.asset(AppAssets.hemBurgerMenuIcon),
              ),
            ),
          ],
        ),
        body: SmartRefresher(
          controller: authorizePikupController.refreshController,
          onRefresh: () {
            authorizePikupController.onRefresh();
          },
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(
            complete: Icon(
              Icons.done,
              color: AppColor.appPrimary,
            ),
            waterDropColor: AppColor.appPrimary,
          ),
          child: SingleChildScrollView(
            child: GetBuilder<AuthorizePikupController>(
              builder: (controller) => controller
                      .listOfAuthorizePickup.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.listOfAuthorizePickup.length,
                      itemBuilder: (context, index) {
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.listOfAuthorizePickup[index]
                              .authorizedPickUpDetailModelList.length,
                          itemBuilder: (context, indexVal) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xff764abc),
                                child: Text(controller
                                    .listOfAuthorizePickup[index]
                                    .authorizedPickUpDetailModelList[indexVal]
                                    .pickupByFirstName
                                    .trim()[0]),
                              ),
                              title: Text(
                                  '${controller.listOfAuthorizePickup[index].authorizedPickUpDetailModelList[indexVal].pickupByFirstName} ${controller.listOfAuthorizePickup[index].authorizedPickUpDetailModelList[indexVal].pickUpByLastName}'),
                              subtitle: Text(
                                  '${controller.listOfAuthorizePickup[index].authorizedPickUpDetailModelList[indexVal].dateFrom} - ${controller.listOfAuthorizePickup[index].authorizedPickUpDetailModelList[indexVal].dateTo}'),
                              trailing: Container(
                                alignment: Alignment.center,
                                width: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await controller
                                              .deleteAuthorizePickup(controller
                                                  .listOfAuthorizePickup[index]
                                                  .authorizedPickUpDetailModelList[
                                                      indexVal]
                                                  .authorizedPickUpDetailId);
                                          messageToastSuccess(context, "",
                                              "Deleted successfully.");
                                        },
                                        child: const Icon(
                                            Icons.delete_outline_rounded)),
                                    InkWell(
                                      onTap: () async {
                                        if (await Get.toNamed(
                                            AppRoute.updateAuthorizePickup,
                                            arguments: {
                                              ArgumentKeys
                                                      .argumenntAuthorizePickupList:
                                                  controller
                                                          .listOfAuthorizePickup[
                                                              index]
                                                          .authorizedPickUpDetailModelList[
                                                      indexVal],
                                              ArgumentKeys.studentFirstName:
                                                  controller
                                                      .listOfAuthorizePickup[
                                                          index]
                                                      .studentFirstName,
                                              ArgumentKeys.studentLastName:
                                                  controller
                                                      .listOfAuthorizePickup[
                                                          index]
                                                      .studentLastName,
                                            })) {
                                          authorizePikupController
                                              .getListOfAuthorizePickup(
                                                  authorizePikupController
                                                      .url.value);
                                        }
                                      },
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 0.2,
                            );
                          },
                        );
                      },
                    )
                  : controller.filterStartDate.trim().isEmpty &&
                          controller.filterEndDate.trim().isEmpty
                      ? const Center(
                          child: Image(
                            image: AssetImage(AppAssets.authorizePickupPng),
                            height: 200,
                            width: 200,
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage(
                                    AppAssets.authorizePickupNodataIcon),
                                height: 150,
                                width: 150,
                              ),
                              SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: Text(
                                    "There are no authorized pickups  schduled",
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
            ),
          ),
        ));
  }
}
