import 'package:get/get.dart';

import '../../../controller/Admin/staff_management/admin_staff_profile.dart';

class  AdminStaffProfileBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(AdminStaffProfileController());
  }

}