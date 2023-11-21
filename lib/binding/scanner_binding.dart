import 'package:get/get.dart';
import 'package:preto3/controller/scanner_controller.dart';

class ScannerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ScannerController());
  }

}