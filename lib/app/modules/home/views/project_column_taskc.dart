import 'package:flutter/material.dart';
import 'package:taskwarrior/app/utils/app_settings/app_settings.dart';
import 'package:taskwarrior/app/utils/constants/taskwarrior_fonts.dart';
import 'package:taskwarrior/app/utils/gen/fonts.gen.dart';
import 'package:taskwarrior/app/utils/themes/theme_extension.dart';
import 'package:taskwarrior/app/utils/language/sentence_manager.dart';

class ProjectColumnTaskc extends StatelessWidget {
  const ProjectColumnTaskc({
    super.key,
    required this.projects,
    required this.projectFilter,
    required this.callback,
  });

  final List<String> projects;
  final String projectFilter;
  final void Function(String) callback;

  @override
  Widget build(BuildContext context) {
    TaskwarriorColorTheme tColors =
        Theme.of(context).extension<TaskwarriorColorTheme>()!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                SentenceManager(
                  currentLanguage: AppSettings.selectedLanguage,
                ).sentences.project,
                style: TextStyle(
                  fontFamily: FontFamily.poppins,
                  fontWeight: TaskWarriorFonts.bold,
                  fontSize: TaskWarriorFonts.fontSizeSmall,
                  color: tColors.primaryTextColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    projectFilter.isEmpty
                        ? SentenceManager(
                                currentLanguage: AppSettings.selectedLanguage)
                            .sentences
                            .notSelected
                        : projectFilter,
                    style: TextStyle(
                      fontFamily: FontFamily.poppins,
                      fontSize: TaskWarriorFonts.fontSizeSmall,
                      color: tColors.primaryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ProjectTileTaskc(
            project: SentenceManager(
              currentLanguage: AppSettings.selectedLanguage,
            ).sentences.allProjects,
            projectFilter: projectFilter,
            callback: callback),
        if (projects.isNotEmpty)
          ...projects.map((entry) => ProjectTileTaskc(
                project: entry,
                projectFilter: projectFilter,
                callback: callback,
              ))
        else
          Column(
            children: [
              Text(
                SentenceManager(currentLanguage: AppSettings.selectedLanguage)
                    .sentences
                    .noProjectsFound,
                style: TextStyle(
                  fontFamily: FontFamily.poppins,
                  fontSize: TaskWarriorFonts.fontSizeSmall,
                  color: tColors.primaryTextColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
      ],
    );
  }
}

class ProjectTileTaskc extends StatelessWidget {
  const ProjectTileTaskc({
    super.key,
    required this.project,
    required this.projectFilter,
    required this.callback,
  });

  final String project;
  final String projectFilter;
  final void Function(String) callback;

  @override
  Widget build(BuildContext context) {
    TaskwarriorColorTheme tColors =
        Theme.of(context).extension<TaskwarriorColorTheme>()!;
    return GestureDetector(
      onTap: () => callback(project),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<String>(
            value: project,
            groupValue: projectFilter,
            onChanged: (_) => callback(project),
          ),
          Text(
            project,
            style: TextStyle(
              color: tColors.primaryTextColor,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
