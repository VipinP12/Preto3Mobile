import 'package:get/get.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';

class CommunicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CommunicationController());
  }
}
