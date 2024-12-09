import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class Project {
  final String title;
  final String description;
  final String image;
  final List<String> features;
  final Color iconBgColor;
  final String label;
  final String textIcon;
  final String textWithIcon;

  Project({
    required this.title,
    required this.description,
    required this.image,
    required this.features,
    required this.iconBgColor,
    required this.label,
    required this.textIcon,
    required this.textWithIcon,
  });
}

class ProjectGenerationOne {
  final List<Project> projects;

  ProjectGenerationOne({
    required this.projects,
  });
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  final String svgIcon = '''
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <path fill="currentColor" d="M5.5 7A1.5 1.5 0 0 1 4 5.5A1.5 1.5 0 0 1 5.5 4A1.5 1.5 0 0 1 7 5.5A1.5 1.5 0 0 1 5.5 7m15.91 4.58l-9-9C12.05 2.22 11.55 2 11 2H4c-1.11 0-2 .89-2 2v7c0 .55.22 1.05.59 1.41l8.99 9c.37.36.87.59 1.42.59s1.05-.23 1.41-.59l7-7c.37-.36.59-.86.59-1.41c0-.56-.23-1.06-.59-1.42"/>
    </svg>
  ''';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Text(
                      project.image,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: SvgPicture.string(
                          svgIcon,
                          width: 20,
                          height: 20,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        project.textWithIcon,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(project.label,style: const TextStyle(color: AppColors.secondaryColor,fontWeight: FontWeight.w700,fontSize: 12),),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                project.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              ...project.features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      feature,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
