import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/components/update_alertbox.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/role_model.dart';
import 'package:preto3/model/school_type_model.dart';
import 'package:preto3/network/socket_server.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../network/api_end_points.dart';
import '../network/base_client.dart';
import '../network/is_internet_connected.dart';

class SelectRoleController extends GetxController with BaseController {
  final storageBox = GetStorage();
  var roleId = 0.obs;
  var classId = 1000397.obs;
  var schoolId = 0.obs;

  var roleIndex = 0.obs;

  RoleModel? roleType;
  var selectedSchool = "".obs;
  var selectedRole = "".obs;

  var schoolName = "".obs;
  var roleListFromStorage = "".obs;

  var roleList = <dynamic>[];
  final allROles = <RoleModel?>[].obs;
  final filteredRole = <RoleModel?>[].obs;
  final allSchools = <RoleModel?>[].obs;
  final schoolList = <String?>[].obs;
  final allFilterSchool = <SchoolTypeModel?>[].obs;
  var uniqSet = Set<String>();
  List<RoleModel?> uniquelist = [];

  var deviceToken = "".obs;
  var systemOs = "".obs;
  var systemModel = "".obs;

  @override
  void onInit() {
    // print("Socket server Connection in select role screen.");
    // SocketServer.instance!
    //     .connectToWebSocket(storageBox.read(AppKeys.keyUserName));
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   print(result);
    //   checkNetwork();
    // });
    super.onInit();
    setDeviceInfo();
  }

  @override
  void onReady() {
    roleList = storageBox.read(AppKeys.keyRoleList);

    var res = json.encode(roleList);

    allROles.value = roleModelFromJson(res)!;

    uniquelist = allROles
        .where((element) => uniqSet.add(element!.schoolName.toString()))
        .toList();
    uniquelist = allROles
        .where((element) => uniqSet.add(element!.schoolId.toString()))
        .toList();

    if (uniquelist.isNotEmpty && uniquelist.length == 1) {
      roleType = uniquelist.first!;
      setSchool(roleType!);
    }
    //Future.delayed()
    Future.delayed(const Duration(seconds: 30), () {
      UpdateAlert.updateAlertBox();
    });

    update();
  }

  @override
  void dispose() {
    log("Destroy select  role===============");
    SocketServer.instance!.socket.close();
    super.dispose();
  }

  void setSchool(RoleModel roleModel) {
    filteredRole.clear();
    roleType = roleModel;
    schoolId.value = roleModel.schoolId!;
    storageBox.write(AppKeys.keyRoleId, roleModel.roleId);
    storageBox.write(AppKeys.keySchoolId, roleModel.schoolId);
    selectedSchool.value = roleModel.schoolName.toString();
    roleId.value = roleModel.roleId!;
    selectedRole.value = roleModel.roleName.toString();
    for (var element in allROles) {
      if (schoolId.value == element!.schoolId) {
        filteredRole.add(element);
      }
      // roleId.value = filteredRole.first!.roleId!;
      // schoolId.value = filteredRole.first!.schoolId!;
    }
    update();
  }

  void changeRole(int index) {
    roleIndex.value = index;
    roleId.value = filteredRole[index]!.roleId!;
    schoolId.value = filteredRole[index]!.schoolId!;
    storageBox.write(AppKeys.keyRoleId, roleId.value);
    storageBox.write(AppKeys.keySchoolId, schoolId.value);
    storageBox.write(AppKeys.keySchoolQRCode, filteredRole[index]!.qrCode);
    update();
  }

  Future<void> addTokenToNotification() async {
    var notificationTokenParems = {
      "deviceToken": deviceToken.value,
      "schoolId": storageBox.read(AppKeys.keySchoolId),
      "roleId": storageBox.read(AppKeys.keyRoleId),
      "deviceOS": systemOs.value,
      "deviceModel": systemModel.value,
      "deviceType": Platform.isIOS ? "1" : "2"
    };
    print(
        "Notification device token payload ==>${json.encode(notificationTokenParems)}");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.userRegisterDeviceInfo,
            notificationTokenParems)
        .catchError(handleError);
    print(response);
  }

  Future<String> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    return token.toString();
  }

  void setDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      deviceToken.value = await getDeviceTokenToSendNotification();
      systemOs.value = Platform.operatingSystemVersion;
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      systemModel.value = androidInfo.model;
    } else if (Platform.isIOS) {
      deviceToken.value = await getDeviceTokenToSendNotification();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      systemOs.value = Platform.operatingSystemVersion;
      systemModel.value = iosInfo.utsname.machine!;
    }
  }

  void checkNetwork() async {
    if (await InternetConnection.checkIsInternetConnected()) {
      print("Connected Network");
    } else {
      if (storageBox.read(AppKeys.keyUserName) != null) {
        SocketServer.instance!.socket.close();
        if (SocketServer.instance!.socket.connection.state is Disconnected) {
          Future.delayed(Duration(seconds: 2), () async {
            SocketServer.instance!
                .connectToWebSocket(storageBox.read(AppKeys.keyUserName));
          });

          print(
              "Check Socket Connection in splash screen. Connection again  connected");
        }
      }
      //print("Diconnected");
    }
  }
}
