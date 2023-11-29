

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AdminStaffProfileController extends GetxController{

  String selectedValue = 'Hindi';
  String selectedRole = 'Teacher';
  String selectedAssignName = 'Assign New Room';
  bool isSwitched = false;

  List<AuthorizePickup> authorizePickUPList = [
    AuthorizePickup(
      title: 'Amelia Wilson',
    ),
    AuthorizePickup(
      title: 'Amelia Wilson',
    ),
    AuthorizePickup(
      title: 'Amelia Wilson',
    ),
    AuthorizePickup(
      title: 'Amelia Wilson',
    ),

  ];
}
class AuthorizePickup {
  String title;


  AuthorizePickup({
    required this.title,
  });
}