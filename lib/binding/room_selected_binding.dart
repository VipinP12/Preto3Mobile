import 'package:get/get.dart';
import 'package:preto3/controller/room_selected_controller.dart';

import '../controller/checkin_controller.dart';

class RoomSelectedBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RoomSelectedController());
    Get.put(CheckInController());

  }

}