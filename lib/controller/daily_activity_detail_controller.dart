import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/argument_keys.dart';

import '../model/daily_activity_model.dart';

class DailyActivityDetailController extends GetxController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  final studentDailyActivity = <Activity>[].obs;
  Student? student;
  var activityDate = "".obs;
  var studentName = "".obs;
  var studentProfilePic = "".obs;
  var argumentActivityImgUrls = [].obs;
  var roleId = 0.obs;
  @override
  void onInit() {
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    activityDate.value = argumentData[ArgumentKeys.argumentDailyActivityDate];
    studentName.value = argumentData[ArgumentKeys.argumentDailyActivityName];
    studentProfilePic.value =
        argumentData[ArgumentKeys.argumentDailyActivityPic];
    studentDailyActivity.value = argumentData[ArgumentKeys.argumentDailyMap];
    argumentActivityImgUrls.value =
        argumentData[ArgumentKeys.argumentActivityImgUrls];
    print(argumentActivityImgUrls.value);
    print("STUDENT DATE:${activityDate.value}");
    print("STUDENT MAP:$student");
    print("STUDENT LIST:${studentDailyActivity.length}");
    super.onInit();
  }
}
