import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/room_list_model.dart';
import '../../model/room_selected_model.dart';
import '../../network/api_end_points.dart';
import '../../network/base_client.dart';
import '../../utils/app_dialog.dart';
import '../../utils/app_keys.dart';
import '../../utils/argument_keys.dart';
import '../base_controller.dart';

class AdminStaffController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;

  var roleId = 0.obs;
  var schoolId = 0.obs;
  var classId = 0.obs;

  var selectedClassRoom = "".obs;
  var selectedClassRoomId = 0.obs;
  var staffTotal = 0.obs;
  var staffCheckedIn = 0.obs;
  var staffCheckedOut = 0.obs;
  var staffAbsent = 0.obs;

  final allStudentList = <RoomSelectedModel?>[].obs;
  final allRoomList = <RoomListModel?>[].obs;
  RoomListModel? myRoom;

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


  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    log(argumentData.toString());
     staffTotal.value = argumentData[ArgumentKeys.argumentStaffTotal];
    staffCheckedIn.value = argumentData[ArgumentKeys.argumentCheckIn];
    staffCheckedOut.value = argumentData[ArgumentKeys.argumentStaffCheckOut];
    staffAbsent.value = argumentData[ArgumentKeys.argumentStaffAbsent];
    log("TOTAL STUDENT:${staffTotal.value}");
    super.onInit();
  }

  @override
  void onReady() {
    getAllRoomList(roleId.value, schoolId.value);
    super.onReady();
  }




  void setRoom(RoomListModel room) {
    myRoom = room;
    selectedClassRoom.value = room.className.toString();
    selectedClassRoomId.value = room.classId!.toInt();
    getAllActiveStudentInRoom(
        roleId.value, schoolId.value, selectedClassRoomId.value);
    update();
  }

  void getAllRoomList(int roomId, int schoolId) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
        '${ApiEndPoints.allRoom}' '?roleId=$roleId&schoolId=$schoolId')
        .catchError(handleError);
    if (response != null) {
      log("RESPONSE:$response");
      allRoomList.value = roomListModelFromJson(response)!;
      hideLoading();
      update();
    } else {
      log("ERROR BOOL:${isError.value}");
      log("ERROR RESPONSE:${errorMessage.toString()}");
      update();
    }
  }
  void getAllActiveStudentInRoom(int roleId, int schoolId, int classId) async {
    showLoading();
    var response = await BaseClient()
        .get(
        ApiEndPoints.devBaseUrl,
        '${ApiEndPoints.allRoomStudent}'
            '?roleId=$roleId&schoolId=$schoolId&classId=$classId')
        .catchError(handleError);
    allStudentList.value = roomSelectedModelFromJson(response);
    log("ALL STUDENTS IN ROOM :${allStudentList.length}");
    hideLoading();
    update();
  }

}
class AuthorizePickup {
  String title;


  AuthorizePickup({
    required this.title,
  });
}