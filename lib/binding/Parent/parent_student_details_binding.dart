import 'package:get/instance_manager.dart';
import 'package:preto3/controller/Parent/parent_student_details_controller.dart';

class ParentStudentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ParentStudentDetailsController());
  }
}
