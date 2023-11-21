import 'package:get/get.dart';

import '../../controller/Bank/add_bank_atmcard_controller.dart';

class AddBankAtmCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddBankAtmcardController());
  }
}
