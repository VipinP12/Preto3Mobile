import 'package:get/get.dart';
import 'package:preto3/controller/student_controller.dart';

class StudentBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(StudentController());
  }

}