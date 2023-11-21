import 'package:get/get.dart';
import 'package:preto3/controller/event_controller.dart';

class EventBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(EventController());
  }

}