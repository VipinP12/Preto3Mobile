import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/controller/base_controller.dart';

import '../../model/parent/childern_fees_invoice_model.dart';
import '../../utils/argument_keys.dart';

class InvoiceDetailsController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  Invoice? invoice;
  @override
  void onInit() {
    // invoice = argumentData[ArgumentKeys.invoiceDetails];
    // print(argumentData[ArgumentKeys.invoiceDetails]);
    invoice = Invoice.fromJson(argumentData[ArgumentKeys.invoiceDetails]);
    print(invoice);
    super.onInit();
  }

  @override
  void onReady() {}
}
