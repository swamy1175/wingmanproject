import 'package:get/route_manager.dart';


class CustomSnackBar{
  static showSnackBar(String title, String message,){
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }
}