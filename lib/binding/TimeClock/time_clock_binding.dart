import 'package:get/get.dart';
import 'package:preto3/controller/TimeClock/time_clock_controller.dart';

class TimeClockBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(TimeClockController());
  }

}