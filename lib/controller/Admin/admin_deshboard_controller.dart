

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/app_keys.dart';

class AdminDashboardController extends GetxController{
  final storageBox = GetStorage();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var firstName = "".obs;
  var qrCode = "".obs;

  @override
  void onInit(){
    // firstName.value = storageBox.read(AppKeys.keyFirstName);
    super.onInit();
  }
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

}