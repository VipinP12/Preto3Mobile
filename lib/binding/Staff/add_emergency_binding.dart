import 'package:get/get.dart';
import 'package:preto3/controller/Staff/add_emergency_controller.dart';

class AddEmergencyBinding extends Bindings{
  
  @override
  void dependencies() {
    Get.put(AddEmergencyController());
  }
  
}