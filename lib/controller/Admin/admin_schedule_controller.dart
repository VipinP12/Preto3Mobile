import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScheduleController extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController tabController;
  var isError = false.obs;
  var errorMessage = "No Data".obs;

  final List<Tab> scheduleTabs=const[
    Tab(text: "Students",),
    Tab(text: "Staff",),
  ];



  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: scheduleTabs.length, vsync: this, );
  }
}
