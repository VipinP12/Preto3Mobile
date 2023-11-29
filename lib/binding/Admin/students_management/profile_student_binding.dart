import 'package:get/get.dart';
import 'package:preto3/controller/Admin/drawer_controller/profile_student_controller.dart';

class ProfileStudentBinding extends Bindings{

  @override
  void dependencies() {
   Get.put(ProfileStudentController());
  }

}