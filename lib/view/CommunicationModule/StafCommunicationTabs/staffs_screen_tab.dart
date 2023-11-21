import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../../../controller/Communication/communication_controller.dart';
import '../../../network/socket_server.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_keys.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/argument_keys.dart';
import '../../../utils/toast.dart';

class StaffScreenTab extends StatelessWidget {
  const StaffScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: GetBuilder<CommunicationController>(
            builder: (commController) => SmartRefresher(
                  controller: commController.refreshControllerStaffs,
                  onRefresh: () {
                    commController.onRefreshStaffs();
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
                  child: SingleChildScrollView(
                      child: commController.getStaffList.isNotEmpty
                          ? ListView.separated(
                              itemCount: commController.getStaffList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    commController.hideLoading();
                                    commController.messageList.value = [];
                                    commController.update();

                                    if (SocketServer.instance!.socket.connection
                                            .state is Connected ||
                                        SocketServer.instance!.socket.connection
                                            .state is Reconnected) {
                                      Get.toNamed(AppRoute.chat, arguments: {
                                        ArgumentKeys.argumentChatUsername:
                                            commController
                                                .getStaffList[index].roomName,
                                        ArgumentKeys.argumentChatUserId:
                                            commController
                                                .getStaffList[index].roomId,
                                        ArgumentKeys.rollIdToChat: 2
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
                                          horizontal: 16.0),
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
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    profileFirstName(
                                                        commController
                                                            .getStaffList[index]
                                                            .roomName
                                                            .trim()),
                                                imageUrl: commController
                                                    .getStaffList[index]
                                                    .userProfilePic,
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    profileFirstName(
                                                        commController
                                                            .getStaffList[index]
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
                                                        commController
                                                            .getStaffList[index]
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
                                                        commController
                                                            .getStaffList[index]
                                                            .message,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
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
                                                      commController
                                                          .getTimeOrDate(
                                                              commController
                                                                  .getStaffList[
                                                                      index]
                                                                  .date,
                                                              context),
                                                      /*DateFormat("hh:mm a").format(DateTime.parse(commController.messageList[commController.messageList.length].date.toString())),*/
                                                      style: GoogleFonts.poppins(
                                                          color: AppColor
                                                              .heavyTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  /* Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .red,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                                    10)),
                                                                        child: Center(
                                                                          child: Text(
                                                                            "20",
                                                                            style: GoogleFonts.poppins(
                                                                                color: Colors
                                                                                    .white,
                                                                                fontSize:
                                                                                    10,
                                                                                fontWeight:
                                                                                    FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                      )*/
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
                            )
                          : noStudentGrouStafFround(
                              "Ther are no staffs found in the school",
                              context)),
                )));
  }

  Widget noStudentGrouStafFround(String textVal, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Text(
            textVal,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: AppColor.heavyTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
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
          color: Colors.grey.shade300),
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
