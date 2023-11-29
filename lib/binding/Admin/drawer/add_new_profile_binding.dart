import 'package:get/get.dart';

import '../../../controller/Admin/students_management/add_new_student_controller.dart';

class AddNewProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileAddStudentController());

  }

}