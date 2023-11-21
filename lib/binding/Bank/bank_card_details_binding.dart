import 'package:get/get.dart';
import 'package:preto3/controller/Parent/view_invoice_controller.dart';
import '../../controller/Bank/bank_card_details_controller.dart';

class BankCardDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BankCardDetailsController());
    Get.put(ViewInvoiceController());
  }
}
