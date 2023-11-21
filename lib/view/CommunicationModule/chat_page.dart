import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:preto3/controller/Communication/chat_controller.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/model/chat_message_model.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:file_picker/file_picker.dart';

import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:preto3/utils/toast.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../service/download_pdf.dart';
import '../../utils/argument_keys.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = Get.find<ChatController>();
  final communicationController = Get.find<CommunicationController>();
  PlatformFile? platformFile;
  final manager = DounloadPDF();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        leadingWidth: 30,
        centerTitle: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  chatController.name.value.trim()[0],
                  style: GoogleFonts.poppins(
                      color: AppColor.appPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Obx(() => Flexible(
                  child: Text(
                    chatController.name.value,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ))
          ],
        ),
        actions: [
          Obx(() => communicationController.roleId.value == 4
              ? Container()
              : PopupMenuButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  itemBuilder: (context) {
                    return [
                      // PopupMenuItem<int>(
                      //     value: 0,
                      //     child: Text(
                      //       AppString.viewProfile,
                      //       style: GoogleFonts.poppins(
                      //           color: AppColor.heavyTextColor,
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w400),
                      //     )),
                      // PopupMenuItem<int>(
                      //     value: 1,
                      //     child: Text(
                      //       AppString.clearHistory,
                      //       style: GoogleFonts.poppins(
                      //           color: AppColor.heavyTextColor,
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w400),
                      //     )),
                      PopupMenuItem<int>(
                          value: 2,
                          onTap: () async {
                            if (SocketServer.instance != null) {
                              chatController.showLoading();
                              await communicationController.deleteGroup(
                                  chatController.jid.value,
                                  chatController.rollId.value);
                              chatController.hideLoading();
                              communicationController.update();
                              Get.back();
                              Get.back();
                            } else {
                              messageToastWarning(context,
                                  "Somthing went wrong. Right now can not delete group.");
                            }
                          },
                          child: Text(
                            AppString.deleteChat,
                            style: GoogleFonts.poppins(
                                color: AppColor.heavyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ];
                  }))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  color: Colors.white,
                  child: GetBuilder<CommunicationController>(
                      builder: (controller) => controller.messageList.isNotEmpty
                          ? StickyGroupedListView<MessageResponse, DateTime>(
                              elements: controller.messageList,
                              order: StickyGroupedListOrder.DESC,
                              groupBy: (MessageResponse element) => DateTime(
                                element.date!.year,
                                element.date!.month,
                                element.date!.day,
                              ),
                              reverse: true,
                              groupComparator:
                                  (DateTime value1, DateTime value2) =>
                                      value1.compareTo(value2),
                              itemComparator: (MessageResponse element1,
                                      MessageResponse element2) =>
                                  element1.date!
                                      .compareTo(element2.date as DateTime),
                              floatingHeader: true,
                              groupSeparatorBuilder: _getGroupSeparator,
                              itemBuilder: chatItem,
                            )
                          : Center(
                              child: Text(
                                'No messages',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: AppColor.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            )))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.borderColor, width: 0.5)),
              child: chatController.rollId == 3 &&
                      chatController.argumentData[ArgumentKeys.broadCastFlag]
                  ? Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        "You can not reply to this message.",
                        style: GoogleFonts.poppins(
                            color: AppColor.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Form(
                            key: chatController.messageKey,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColor.appPrimary,
                              focusNode: chatController.sendFocusNode,
                              onTap: () {
                                chatController.focusSendIcons(true);
                              },
                              maxLines: 6,
                              minLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              decoration: InputDecoration(
                                hintText: AppString.typeMessage,
                                helperStyle: GoogleFonts.poppins(
                                    color: AppColor.mediumTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              controller: chatController.messageController,
                              onChanged: (changeValue) {},
                              onSaved: (savedValue) {
                                chatController.messageController.text =
                                    savedValue!;
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                platformFile = null;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Select option'),
                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              await sendPdf();
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text("Select file",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              await sendImage();
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text("Select image",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SvgPicture.asset(
                                  AppAssets.attachIcon,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (!chatController.fileUploadloader.value) {
                                  if (chatController.rollId == 3) {
                                    if (chatController.argumentData[
                                        ArgumentKeys.broadCastFlag]) {
                                      return;
                                    }
                                  }
                                  if (SocketServer.instance != null) {
                                    SocketServer.instance!.sendMyMessage(
                                        chatController.messageController.text,
                                        chatController.jid.value,
                                        "");
                                    chatController.messageController.clear();
                                    chatController.focusSendIcons(false);
                                  }
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Obx(
                                    () => chatController.fileUploadloader.value
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ))
                                        : SvgPicture.asset(
                                            AppAssets.sendIcon,
                                            color: AppColor.appPrimary,
                                          )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getGroupSeparator(MessageResponse element) {
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputChatDate =
        outputFormat.format(DateTime.parse(element.date.toString()));
    var outputChatDateFormat = DateFormat('dd MMM yyyy');
    var currentChatDate =
        outputChatDateFormat.format(DateTime.parse(DateTime.now().toString()));

    return SizedBox(
      height: 40,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                currentChatDate == outputChatDate ? "Today" : outputChatDate,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: AppColor.appPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              )),
        ),
      ),
    );
  }

  Widget senderLayout(BuildContext context, MessageResponse messageResponse) {
    String type =
        messageResponse.type.substring(messageResponse.type.indexOf("/") + 1);
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: const BoxDecoration(
          color: AppColor.appPrimary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            messageResponse.type.trim() == ""
                ? Text(
                    messageResponse.message,
                    style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                : type == "png" || type == "jpg" || type == "jpeg"
                    ? InkWell(
                        onTap: () async {
                          File file =
                              await manager.startDownloadingInCommunication(
                                  messageResponse.message.trim());
                          OpenFilex.open(file.path);
                        },
                        child: Container(
                          height: 180,
                          margin: const EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const Image(
                                image: AssetImage(
                                  AppAssets.noImageFound,
                                ),
                                fit: BoxFit.contain,
                              ),
                              imageUrl: messageResponse.message.trim(),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Image(
                                height: 75,
                                width: 75,
                                image: AssetImage(
                                  AppAssets.noImageFound,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          File file =
                              await manager.startDownloadingInCommunication(
                                  messageResponse.message.trim());
                          OpenFilex.open(file.path);
                        },
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(
                              right: 10, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.insert_drive_file_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 130,
                                    child: Text(
                                      messageResponse.message.substring(
                                          messageResponse.message
                                                  .lastIndexOf("/") +
                                              1),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              FutureBuilder<bool>(
                                  future:
                                      manager.isCommunicationDownloadFileExist(
                                          messageResponse.message.substring(
                                              messageResponse.message
                                                      .lastIndexOf("/") +
                                                  1)),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    return snapshot.data != null &&
                                            snapshot.data != true
                                        ? Container(
                                            height: 35,
                                            width: 35,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: InkWell(
                                              onTap: () async {
                                                await manager.startDownloading(
                                                    messageResponse.message);
                                                setState(() {});
                                              },
                                              child: const Icon(
                                                Icons.download,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        : Container();
                                  })
                            ],
                          ),
                        ),
                      ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat("hh:mm a")
                    .format(messageResponse.date as DateTime)
                    .toString(),
                style: GoogleFonts.roboto(
                    color: AppColor.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receiverLayout(BuildContext context, MessageResponse messageResponse) {
    String type =
        messageResponse.type.substring(messageResponse.type.indexOf("/") + 1);
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: const BoxDecoration(
          color: AppColor.disableColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            messageResponse.type.trim() == ""
                ? Text(
                    messageResponse.message,
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                : type == "png" || type == "jpg" || type == "jpeg"
                    ? InkWell(
                        onTap: () async {
                          File file =
                              await manager.startDownloadingInCommunication(
                                  messageResponse.message.trim());
                          OpenFilex.open(file.path);
                        },
                        child: Container(
                          height: 180,
                          margin: const EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const Image(
                                image: AssetImage(
                                  AppAssets.noImageFound,
                                ),
                                fit: BoxFit.contain,
                              ),
                              imageUrl: messageResponse.message.trim(),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Image(
                                height: 75,
                                width: 75,
                                image: AssetImage(
                                  AppAssets.noImageFound,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          File file =
                              await manager.startDownloadingInCommunication(
                                  messageResponse.message.trim());
                          OpenFilex.open(file.path);
                        },
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(
                              right: 10, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.insert_drive_file_rounded,
                                    color: AppColor.heavyTextColor,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 130,
                                    child: Text(
                                      messageResponse.message.substring(
                                          messageResponse.message
                                                  .lastIndexOf("/") +
                                              1),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              FutureBuilder<bool>(
                                  future:
                                      manager.isCommunicationDownloadFileExist(
                                          messageResponse.message.substring(
                                              messageResponse.message
                                                      .lastIndexOf("/") +
                                                  1)),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    return snapshot.data != null &&
                                            snapshot.data != true
                                        ? Container(
                                            height: 35,
                                            width: 35,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: InkWell(
                                              onTap: () async {
                                                await manager.startDownloading(
                                                    messageResponse.message);
                                                setState(() {});
                                              },
                                              child: const Icon(
                                                Icons.download,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        : Container();
                                  })
                            ],
                          ),
                        ),
                      ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat("hh:mm a").format(messageResponse.date as DateTime),
                style: GoogleFonts.poppins(
                    color: AppColor.mediumTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatItem(BuildContext context, MessageResponse index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment:
            index.sender == 0 ? Alignment.centerRight : Alignment.centerLeft,
        child: index.sender == 0
            ? senderLayout(context, index)
            : receiverLayout(context, index),
      ),
    );
  }

  sendPdf() async {
    await pickFile();
    await sendFile();
  }

  sendImage() async {
    await pickFileImage();
    await sendFile();
  }

  sendFile() async {
    if (platformFile != null) {
      print(platformFile!.size);
      if (platformFile!.size < 2097152) {
        String url = await chatController.sendFileOnServer(
            lookupMimeType(platformFile!.path.toString()).toString(),
            platformFile!.path.toString(),
            platformFile!.name);
        if (url != "") {
          SocketServer.instance!.sendMyMessage(url, chatController.jid.value,
              lookupMimeType(platformFile!.path.toString()).toString());
          await manager.startDownloadingInCommunication(url);
          setState(() {});
        }
      } else {
        messageToastWarning(context, "File size can't be greater than 2MB.");
      }
    }
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg']);
      if (result == null) return;
      setState(() {
        platformFile = result.files.first;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> pickFileImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result == null) return;
      setState(() {
        platformFile = result.files.first;
      });
    } catch (e) {
      return;
    }
  }
}
