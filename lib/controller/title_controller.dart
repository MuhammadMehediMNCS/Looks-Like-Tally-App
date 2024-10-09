import 'package:get/get.dart';

class TitleController extends GetxController {
  var text = ''.obs;

  void setText(String value) {
    text.value = value;
    update();
  }
}