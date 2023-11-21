import 'package:get/get.dart';
import 'package:preto3/controller/daily_activity_controller.dart';

class DailyActivityBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(DailyActivityController());
  }

}