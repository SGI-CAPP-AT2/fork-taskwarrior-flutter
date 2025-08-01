import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskwarrior/app/utils/constants/constants.dart';
import 'package:taskwarrior/app/utils/themes/theme_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/manage_task_champion_creds_controller.dart';

class ManageTaskChampionCredsView
    extends GetView<ManageTaskChampionCredsController> {
  const ManageTaskChampionCredsView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Built ManageTaskChampionCredsView");
    TaskwarriorColorTheme tColors =
        Theme.of(context).extension<TaskwarriorColorTheme>()!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TaskWarriorColors.kprimaryBackgroundColor,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Configure TaskChampion",
              style: GoogleFonts.poppins(
                color: TaskWarriorColors.white,
                fontSize: TaskWarriorFonts.fontSizeLarge,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info,
              color: TaskWarriorColors.white,
            ),
            onPressed: () async {
              String url = "https://github.com/its-me-abhishek/ccsync";
              if (!await launchUrl(Uri.parse(url))) {
                throw Exception('Could not launch $url');
              }
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TaskWarriorColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: tColors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    style: TextStyle(color: tColors.primaryTextColor),
                    controller: controller.encryptionSecretController,
                    decoration: InputDecoration(
                      labelText: 'Encryption Secret',
                      labelStyle: TextStyle(color: tColors.primaryTextColor),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: tColors.primaryTextColor),
                    controller: controller.clientIdController,
                    decoration: InputDecoration(
                      labelText: 'Client ID',
                      labelStyle: TextStyle(color: tColors.primaryTextColor),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: tColors.primaryTextColor),
                    controller: controller.ccsyncBackendUrlController,
                    decoration: InputDecoration(
                      labelText: 'CCSync Backend URL',
                      labelStyle: TextStyle(color: tColors.primaryTextColor),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.saveCredentials();
                      Get.snackbar(
                        'Success',
                        'Credentials saved successfully',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                      );
                    },
                    child: const Text('Save Credentials'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tip: Click on the info icon in the top right corner to get your credentials',
                    style: TextStyle(
                      fontSize: 15,
                      color: tColors.primaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
