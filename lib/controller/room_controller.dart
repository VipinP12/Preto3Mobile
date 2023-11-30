import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_keys.dart';

import '../model/admit/room_ratio.dart';

class RoomController extends GetxController with GetSingleTickerProviderStateMixin,BaseController{


  final storageBox= GetStorage();

  var roleId=0.obs;
  var schoolId=0.obs;
  var isLoading = false.obs;
  var isVisible = true.obs;
  var isValid = false.obs;

  late TabController tabController;

  final List<Tab> myTabs=const[
    Tab(text: "Room List",),
    Tab(text: "Room Ratio",),
  ];



  List colors = [AppColor.roomColor1, AppColor.roomColor2,AppColor.roomColor3,AppColor.roomColor4];
  Random random = Random();

  int colorIndex = 0;

  final allRoomList =  <RoomListModel?>[].obs;
  final allRoomRatio =  <RoomResponse?>[].obs;


  @override
  void onInit() {
    super.onInit();
    roleId.value=storageBox.read(AppKeys.keyRoleId);
    schoolId.value=storageBox.read(AppKeys.keySchoolId);
    tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    print("ADMIN ROOM");
    getAllRoomList(roleId.value,schoolId.value);
    getAllRoomRatio(schoolId.value);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void getAllRoomList(int roomId, int schoolId) async {
    showLoading('Fetching data');
    var response= await BaseClient().get(ApiEndPoints.devBaseUrl, '${ApiEndPoints.allRoom}''?roleId=$roleId&schoolId=$schoolId').catchError(handleError);
    if(response!=null){
      print("ADMIN ROOM RESPONSE:$response");
      allRoomList.value=roomListModelFromJson(response)!;
      hideLoading();
      update();
    }else{
      print("ERROR BOOL:${isError.value}");
      print("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }

  }
  Future<void> getAllRoomRatio(int schoolId) async {
    showLoading('Fetching data');
    var response= await BaseClient().get(ApiEndPoints.devBaseUrl, '${ApiEndPoints.allRoomRatio}''?schoolId=$schoolId').catchError(handleError);
    if(response!=null){
      print("RESPONSE:$response");
      var roomResponse = RoomRatioModel.fromJson(json.decode(response));
      allRoomRatio.value=roomResponse.roomResponse;
      hideLoading();
      update();
    }else{
      print("ERROR BOOL:${isError.value}");
      print("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }

  }

}
