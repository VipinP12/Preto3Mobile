import 'package:get/get.dart';
import 'package:preto3/controller/Staff/class_room_controller.dart';
import 'package:preto3/controller/Admin/room_management/room_controller.dart';

class RoomBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RoomController());
  }

}