import 'package:get/get.dart';
import 'package:preto3/controller/Communication/chat_controller.dart';

class ChatBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(ChatController());
  }

}