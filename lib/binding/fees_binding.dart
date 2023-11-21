import 'package:get/get.dart';
import 'package:preto3/controller/Bank/bank_card_details_controller.dart';
import 'package:preto3/controller/Parent/fees_controller.dart';

class FeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FeesController());
    Get.put(BankCardDetailsController());
  }
}
