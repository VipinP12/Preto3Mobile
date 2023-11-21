import 'package:get/get.dart';
import 'package:preto3/controller/Staff/staff_student_detail_controller.dart';

class StaffStudentDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(StaffStudentDetailsController());
  }

}