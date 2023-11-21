import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/controller/Parent/parent_dashboard_controller.dart';
import 'package:preto3/model/chat_message_model.dart';

import 'package:preto3/utils/app_keys.dart';

import 'package:web_socket_client/web_socket_client.dart';

import 'api_end_points.dart';

class SocketServer {
  final storageBox = GetStorage();

  static SocketServer? _instance;

  static SocketServer? get instance {
    _instance ??= SocketServer._();

    return _instance;
  }

  final communicationController = Get.put(CommunicationController());

  /// Private constructor
  SocketServer._();

  late WebSocket socket;

  /// connect to web socket
  void connectToWebSocket(String username) {
    // Trigger a timeout if establishing a connection exceeds 10s.
    print("openfire username: $username");
    const backoff = ConstantBackoff(Duration(seconds: 100));
    // socket = WebSocket(Uri.parse('ws://172.20.10.7:8080/chat/$username'),
    //     backoff: backoff);
    // print('ws://localhost:8080/chat/$username');
    socket = WebSocket(Uri.parse(ApiEndPoints.socketUrl + username));
    socket.connection.listen((event) async {
      log("LISTENING TO SOCKET$event");
      // Send a message to the server.
      if (event is Connected) {
        listenToStreamMessage();
      }
      // if (event is Reconnected) {
      //   listenToStreamMessage();
      // }
      // if (event is Disconnected) {
      //   if (storageBox.read(AppKeys.keyUserName) != null) {
      //     SocketServer.instance!
      //         .connectToWebSocket(storageBox.read(AppKeys.keyUserName));
      //   }
      // }
    }, onDone: () {
      log("LISTENING ON DONE");
    }, onError: (error) {
      log("LISTENING ON ERROR");
    });
  }

  void listenToStreamMessage() {
    socket.messages.listen((event) {
      print("LISTENING TO SERVER===>$event");
      var jsonData = jsonDecode(event);

      /// LISTEN TO LIST OF GROUP FROM SERVER

      /// LISTEN TO NEW MESSAGE SEND
      if (jsonData["messageType"] == "NEW_MESSAGE") {
        print("hello");
        var data = ChatMessageModel.fromJson(jsonData);
        var contain = Get.find<CommunicationController>()
            .messageList
            .value
            .where((element) =>
                element.messageId == data.messageResponses[0].messageId);
        if (contain.isEmpty) {
          Get.find<CommunicationController>()
              .messageList
              .value
              .insert(0, data.messageResponses[0]);
          Get.find<CommunicationController>().update();
          Get.find<CommunicationController>()
              .addMessageInGroupLastMessage(data.messageResponses[0]);
          Get.find<CommunicationController>()
              .addMessageInGroupLastMessageNotification(
                  data.messageResponses[0]);
          Get.find<CommunicationController>().update();
        }
      }

      /// LISTEN TO MESSAGES FROM SERVER
      if (jsonData["messageType"] == "GET_LIST_ALL_PREVIOUS_MESSAGE") {
        Get.find<CommunicationController>().messageList.clear();
        var data = ChatMessageModel.fromJson(jsonData);
        Get.find<CommunicationController>().messageList.value =
            data.messageResponses;
        Get.find<CommunicationController>().hideLoading();
        Get.find<CommunicationController>().update();
      }

      /// CREATE A NEW GROUP
      if (jsonData["messageType"] == "CREATE_NEW_GROUP") {
        if (jsonData["content"] == "success") {
          print("GROUP ID FROM OPEN FIRE:${jsonData["groupId"]}");
          Get.find<CommunicationController>().groupId.value =
              jsonData["groupId"];
          if (storageBox.read(AppKeys.keyRoleId) == 4) {
            //Get.find<CommunicationController>().createNewGroup();
          }
          if (storageBox.read(AppKeys.keyRoleId) == 3 &&
              Get.find<CommunicationController>().studentSelect.isTrue) {
            // Get.find<CommunicationController>()
            //     .staffCreateStudentGroup(jsonData["groupId"]);
          }
          if (storageBox.read(AppKeys.keyRoleId) == 3 &&
              Get.find<CommunicationController>().staffSelect.isTrue) {
            // Get.find<CommunicationController>().staffCreateStaffGroup();
          }
        } else {
          print("FAILED TO CREATE A NEW GROUP");
        }
        communicationController.hideLoading();
      }

      if (jsonData["messageType"] == "ERROR") {
        communicationController.hideLoading();
      }
      if (jsonData["messageType"] == "GET_LAST_MESSAGE") {
        var data = ChatMessageModel.fromJson(jsonData);
        Get.find<CommunicationController>()
            .addMessageInGroupLastMessage(data.messageResponses[0]);
        Get.find<CommunicationController>().update();
      }
      if (jsonData["messageType"] == "JOIN_SUCCESS") {
        if (communicationController.roleId.value != 4) {
          for (var element in communicationController.getStaffList) {
            SocketServer.instance!.socket.send(jsonEncode(
                {"groupId": element.roomId, "messageType": "JOIN_GROUP"}));
            SocketServer.instance!.socket.send(jsonEncode({
              "groupId": element.roomId,
              "messageType": "GET_LAST_MESSAGE"
            }));
          }
          for (var element in communicationController.getGroupList) {
            SocketServer.instance!.socket.send(jsonEncode(
                {"groupId": element.roomId, "messageType": "JOIN_GROUP"}));
            SocketServer.instance!.socket.send(jsonEncode({
              "groupId": element.roomId,
              "messageType": "GET_LAST_MESSAGE"
            }));
          }
        }
        for (var element in communicationController.getStudentList) {
          SocketServer.instance!.socket.send(jsonEncode(
              {"groupId": element.roomId, "messageType": "JOIN_GROUP"}));
          SocketServer.instance!.socket.send(jsonEncode(
              {"groupId": element.roomId, "messageType": "GET_LAST_MESSAGE"}));
        }
      }
    });
  }

  /// send message to server
  void sendMyMessage(String message, String jid, String fileType) {
    if (message.isNotEmpty) {
      log("SENDING MESSAGE:$message $jid");
      socket.send(jsonEncode({
        "to": jid,
        "content": message,
        "fileType": fileType,
        "messageType": "NEW_MESSAGE_ON_GROUP"
      }));
    }
  }

  ///get list of groups for
  ///PARENT COMMUNICATION MODULE
  // void getGroups() {
  //   if (storageBox.read(AppKeys.keyRoleId) == 4) {
  //     socket.send(jsonEncode(
  //       {"groupName": "conference", "messageType": "GET_LIST_OF_ALL_GROUPS"},
  //     ));
  //   }
  // }

  /// get list of student for
  /// STAFF COMMUNICATION MODULE
  // void getStudentGroups() {
  //   if (storageBox.read(AppKeys.keyRoleId) == 3) {
  //     socket.send(jsonEncode(
  //       {"groupName": "conference", "messageType": "GET_LIST_OF_ALL_GROUPS"},
  //     ));
  //   }
  // }

  ///get list of staff for
  ///STAFF COMMUNICATION MODULE
  // void getStaffGroups() {
  //   if (storageBox.read(AppKeys.keyRoleId) == 3) {
  //     socket.send(jsonEncode(
  //       {"groupName": "conference", "messageType": "GET_LIST_OF_ALL_GROUPS"},
  //     ));
  //   }
  // }

  ///LOAD ALL MESSAGES ON CHAT
  void loadMessage(String jid) {
    print("JID ON LOAD MESSAGE:$jid");
    socket.send(jsonEncode(
        {"to": jid, "messageType": "GET_LIST_ALL_PREVIOUS_MESSAGE"}));
  }

  ///CREATE A NEW GROUP
  void createNewGroup(String groupId, String groupName) {
    List<String> owners =
        Get.find<ParentDashboardController>().parentUsernameList.value;
    owners.add(Get.find<ParentDashboardController>()
        .allStaff[Get.find<ParentDashboardController>().selectedIndex]!
        .userName);
    var parems = {
      "createGroup": {
        "newGroupName": groupName,
        "newGroupId": groupId,
        "newMessage": "",
        "owners": LinkedHashSet<String>.from(owners).toList(),
        "members": [],
        "outcasts": [],
        "admins": [],
        "maxUser": 40,
        "description": "only for discussion",
        "fileType": "",
      },
      "messageType": "CREATE_NEW_GROUP"
    };
    print(parems);
    socket.send(jsonEncode(parems));
  }

  ///STAFF CREATING STUDENT GROUP
  void staffCreatingStudent(var body) {
    socket.send(jsonEncode(body));
  }

  ///STAFF CREATING STAFF GROUP
  void staffCreatingStaff() {
    socket.send(jsonEncode({
      "createGroup": {
        "newGroupName": Get.find<CommunicationController>().firstname.value,
        "newGroupId":
            "${Get.find<CommunicationController>().firstname}${Get.find<CommunicationController>().userId}${DateTime.now().millisecondsSinceEpoch}",
        "newMessage": "",
        "owners": [Get.find<CommunicationController>().username.value],
        "members": Get.find<CommunicationController>().staffUsernameList,
        "outcasts": [],
        "admins": [],
        "maxUser": 40,
        "description": "only for staff",
        "fileType": "",
      },
      "messageType": "CREATE_NEW_GROUP"
    }));
  }

  ///DELETE A GROUP

  void deleteGroup(String jid) {
    socket.send(jsonEncode({"groupId": jid, "messageType": "DELETE_GROUP"}));
  }

  ///CLEAR CHATS
}
