import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'package:preto3/utils/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../../network/socket_server.dart';
import '../../utils/app_keys.dart';

class ParentCommunicationPage extends StatefulWidget {
  const ParentCommunicationPage({super.key});

  @override
  State<ParentCommunicationPage> createState() =>
      _ParentCommunicationPageState();
}

class _ParentCommunicationPageState extends State<ParentCommunicationPage> {
  final commController = Get.find<ParentDashboardController>();
  final communicationController = Get.find<CommunicationController>();

  @override
  void initState() {
    //SocketServer.instance!.socket.close();
    super.initState();
  }

  @override
  void dispose() {
    log("Destroy select  role===============");
    // SocketServer.instance!.socket.close();
    super.dispose();
  }

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
          centerTitle: false,
          title: Text(
            AppString.communication,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: [
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 4.0),
            //   child: Icon(
            //     Icons.search,
            //     color: Colors.white,
            //     size: 24,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: InkWell(
                onTap: () async => {
                  commController.selectedChildIndex = -1,
                  commController.selectedIndex = -1,
                  if (await Get.toNamed(AppRoute.createStaffGroup))
                    {
                      communicationController
                          .onRefreshCommunicationListOnParent()
                    }
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: communicationController.refreshController1,
          onRefresh: () {
            communicationController.onRefreshCommunicationListOnParent();
          },
          enablePullDown: true,
          enablePullUp: false,
          header: const WaterDropHeader(
            complete: Icon(
              Icons.done,
              color: AppColor.appPrimary,
            ),
            waterDropColor: AppColor.appPrimary,
          ),
          child: communicationController.getStudentList.value.isEmpty
              ? const Center(
                  child: Image(
                    height: 200,
                    width: 200,
                    image: AssetImage(
                      AppAssets.noMessageFound,
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      child: GetBuilder<CommunicationController>(
                        builder: ((controller) => ListView.separated(
                              itemCount: controller.getStudentList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    controller.hideLoading();
                                    controller.messageList.value = [];
                                    controller.update();

                                    if (SocketServer.instance!.socket.connection
                                            .state is Connected ||
                                        SocketServer.instance!.socket.connection
                                            .state is Reconnected) {
                                      Get.toNamed(AppRoute.chat, arguments: {
                                        ArgumentKeys.argumentChatUsername:
                                            controller
                                                .getStudentList[index].roomName,
                                        ArgumentKeys.argumentChatUserId:
                                            controller
                                                .getStudentList[index].roomId,
                                        ArgumentKeys.rollIdToChat: 0
                                      });
                                    } else {
                                      if (SocketServer.instance!.socket
                                          .connection.state is Disconnected) {
                                        SocketServer.instance!
                                            .connectToWebSocket(GetStorage()
                                                .read(AppKeys.keyUserName));
                                      }
                                      messageToastWarning(context,
                                          "Please check your connectivity.");
                                    }
                                  },
                                  child: SizedBox(
                                    height: 80,
                                    width: double.maxFinite,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 42,
                                            width: 42,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    profileFirstName(controller
                                                        .getStudentList[index]
                                                        .roomName
                                                        .trim()),
                                                imageUrl: controller
                                                    .getStudentList[index]
                                                    .userProfilePic,
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    profileFirstName(controller
                                                        .getStudentList[index]
                                                        .roomName
                                                        .trim()),
                                              ),
                                            ),
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
                                              Flexible(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .getStudentList[
                                                                index]
                                                            .roomName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: GoogleFonts.poppins(
                                                            color: AppColor
                                                                .heavyTextColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        controller
                                                            .getStudentList[
                                                                index]
                                                            .message,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts.poppins(
                                                            color: AppColor
                                                                .mediumTextColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  )),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 20,
                                                            left: 10),
                                                    child: Text(
                                                      controller.getTimeOrDate(
                                                          controller
                                                              .getStudentList[
                                                                  index]
                                                              .date,
                                                          context),
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              )
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
                            )),
                      )),
                ),
        ));
  }

  Widget profileFirstName(String name) {
    return Container(
      height: 35,
      width: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.appPrimary,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Text(
          name[0],
          style: GoogleFonts.poppins(
              color: AppColor.appPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
