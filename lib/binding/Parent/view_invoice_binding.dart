import 'package:get/get.dart';
import 'package:preto3/controller/Parent/view_invoice_controller.dart';

class ViewInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewInvoiceController());
  }
}
