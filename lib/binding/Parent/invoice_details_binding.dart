import 'package:get/get.dart';

import '../../controller/Parent/invoice_details_controller.dart';

class InvoiceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InvoiceDetailsController());
  }
}
