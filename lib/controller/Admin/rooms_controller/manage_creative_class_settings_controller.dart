import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/room/manage_creative_class_settings_model.dart';
import 'package:preto3/utils/app_assets.dart';

class ManageCreativeClassSettingsController extends GetxController
    with GetSingleTickerProviderStateMixin, BaseController {
  late TabController tabController;
  final List<Tab> myTabs = const [
    Tab(text: "Students"),
    Tab(
      text: "Staff",
    ),
  ];
  final personList = <ManageCreativeClassSettingsModel>[].obs;
  RxList<bool> inRoomStatusList = <bool>[].obs;
  RxString hintText =
      "Search student".obs; //work accordingly the tab bar is selected

  @override
  void onInit() {
    super.onInit();
    addItem("hello", "Amelia Wilison");
    addItem("hi", "Alexander Smith");
    inRoomStatusList
        .assignAll(List.generate(personList.length, (index) => true));
    tabController = TabController(length: myTabs.length, vsync: this);
  }

  void addItem(String itemName, String profilePicture) {
    personList.add(ManageCreativeClassSettingsModel(
        name: "Amelia Wilison",
        profilePicture: AppAssets.hello,
        inRoom: false));
  }

  void toggleInRoomsStatus(int index) {
    personList[index].inRoom = !personList[index].inRoom;
    update();
  }
}
