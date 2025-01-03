import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskwarrior/app/utils/app_settings/app_settings.dart';
import 'package:taskwarrior/app/utils/permissions/permissions_manager.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettings.init();

  await PermissionsManager.requestAllPermissions();

# THIS SHOULD RUN FLUTTER CI
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
