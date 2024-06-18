import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeat_exam/screen/edit/controller/edit_controller.dart';
import 'package:repeat_exam/utils/app_routes.dart';
import 'package:repeat_exam/utils/app_theme.dart';

void main() {
  EditController controller = Get.put(EditController());
  controller.changeTheme();
  runApp(
    Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: controller.islight.value ? lightTheme : darkTheme,
        routes: app_routes,
      ),
    ),
  );
}
