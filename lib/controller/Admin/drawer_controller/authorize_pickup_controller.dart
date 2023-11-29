

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AdminAuthorizePickUpController extends GetxController{

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