import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/service/local_notification_service.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_routes.dart';

class SplashController extends GetxController {
  final storageBox = GetStorage();

  // late FirebaseMessaging messaging;
  @override
  void onInit() {
    super.onInit();

    FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          badge: true,
          provisional: false,
          sound: true,
        )
        .then((value) => {
              FirebaseMessaging.instance.getInitialMessage().then(
                (message) {
                  print("FirebaseMessaging.instance.getInitialMessage");
                  if (message != null) {
                    print("New Notification");
                    // if (message.data['_id'] != null) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => DemoScreen(
                    //         id: message.data['_id'],
                    //       ),
                    //     ),
                    //   );
                    // }
                  }
                },
              ),
              FirebaseMessaging.onMessage.listen(
                (message) {
                  print("FirebaseMessaging.onMessage.listen");
                  if (message.notification != null) {
                    print(message.notification!.title);
                    print(message.notification!.body);
                    print("message.data11 ${message.data}");
                    LocalNotificationService.createanddisplaynotification(
                        message);
                  }
                },
              ),
              FirebaseMessaging.onMessageOpenedApp.listen(
                (message) {
                  print("FirebaseMessaging.onMessageOpenedApp.listen");
                  if (message.notification != null) {
                    print(message.notification!.title);
                    print(message.notification!.body);
                    print("message.data22 ${message.data['_id']}");
                  }
                },
              )
            });
    storageBox.writeIfNull(AppKeys.keyIsLogged, false);
    //new for static code
    // storageBox.write(AppKeys.keyFirstName, "vandana");
    // storageBox.write(AppKeys.keyLastName,  "verma");
    //
    Timer(const Duration(seconds: 3), () =>
        //Get.offAndToNamed(AppRoute.dashboard)
       _navigateToNext()
    );
  }

  _navigateToNext() {
    storageBox.read(AppKeys.keyIsLogged) &&
            storageBox.read(AppKeys.keyPunchMasterRoleId) == 6
        ? Get.offAndToNamed(AppRoute.timeClock)
        : storageBox.read(AppKeys.keyIsLogged)
        ? Get.offAndToNamed(AppRoute.selectRole)
        : Get.offAndToNamed(AppRoute.onBoarding);
        //     : Get.offAndToNamed(AppRoute.dashboard);
  }
}
