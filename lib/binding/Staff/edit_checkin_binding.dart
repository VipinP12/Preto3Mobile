import 'package:get/get.dart';
import 'package:preto3/controller/Staff/edit_checkin_controller.dart';

class EditCheckInBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(EditCheckInController());
  }

}