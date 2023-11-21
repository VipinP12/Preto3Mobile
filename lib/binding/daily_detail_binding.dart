import 'package:get/get.dart';
import 'package:preto3/controller/daily_activity_detail_controller.dart';

class DailyDetailBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(DailyActivityDetailController());
  }

}