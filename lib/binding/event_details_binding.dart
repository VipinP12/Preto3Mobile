import 'package:get/get.dart';
import 'package:preto3/controller/event_details_controller.dart';

class EventDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(EventDetailsController());
  }

}