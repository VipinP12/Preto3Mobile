import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:preto3/utils/argument_keys.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../network/api_end_points.dart';
import '../../network/base_client.dart';

class ChatController extends GetxController with BaseController {
  final storageBox = GetStorage();
  final messageKey = GlobalKey<FormState>();
  dynamic argumentData = Get.arguments;
  var messageController = TextEditingController();
  final communicationController = Get.find<CommunicationController>();
  var message = "".obs;
  var senderId = "0".obs;
  var receiverId = "2".obs;
  var userId = "".obs;
  var jid = "".obs;
  var rollId = 0.obs;
  var name = "".obs;
  var fileUploadloader = false.obs;

  types.User? users;

  String connectionStatus = "Disconnected";
  String connectionStatusMessage = "";

  var isSendFocused = false.obs;

  FocusNode sendFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
    name.value = argumentData[ArgumentKeys.argumentChatUsername];
    jid.value = argumentData[ArgumentKeys.argumentChatUserId];
    rollId.value = argumentData[ArgumentKeys.rollIdToChat];
    update();
  }

  @override
  void onReady() {
    showLoading();
    SocketServer.instance!.loadMessage(jid.value);
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  focusSendIcons(bool value) {
    isSendFocused.value = value;
    update();
  }

  Future<String> sendFileOnServer(
      String meemType, String path, String name) async {
    fileUploadloader.value = true;
    try {
      var response = await BaseClient()
          .postMultipart(ApiEndPoints.devBaseUrl,
              ApiEndPoints.uploadCommunicationFile, path, name)
          .catchError(handleError);
      if (response != null || response != "") {
        var resp = await http.Response.fromStream(response);
        var encodeFirst = json.encode(resp.body);
        var data = json.decode(encodeFirst);
        fileUploadloader.value = false;
        return data.toString();
      }
    } catch (e) {
      fileUploadloader.value = false;
    }
    fileUploadloader.value = false;
    return "";
  }

  // void sendMyMessage() {
  //   if (messageController.text.isNotEmpty) {
  //     log("SENDING MESSAGE:${messageController.text} ${jid.value.substring(0, jid.value.indexOf("@"))}");
  //     SocketServer.instance!.socket.send(jsonEncode({
  //       "to": jid.value.substring(0, jid.value.indexOf("@")),
  //       "content": messageController.text,
  //       "fileType": "",
  //       "messageType": "NEW_MESSAGE_ON_GROUP"
  //     }));
  //     messageController.text = "";
  //     update();
  //   }
  //   print("JID ON SEND MESSAGE:${jid.value}");
  //   // loadMessage(jid.value);
  // }
}
