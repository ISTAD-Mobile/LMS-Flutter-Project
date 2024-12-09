import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

class BachelorProgramHome extends StatelessWidget {
  BachelorProgramHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BACHELOR PROGRAM'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.defaultWhiteColor,
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: const ExpansionTile(
              title: Text(
                'Year 1',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '1. Introduction to Information and Technology', credit: '3'),
                _CurriculumListTile(subject: '2. Programming Foundation', credit: '3'),
                _CurriculumListTile(subject: '3. Intensive English Program I', credit: '3'),
                _CurriculumListTile(subject: '4. Academic Skill Development', credit: '3'),
                _CurriculumListTile(subject: '5. Multimedia and Web Design', credit: '3'),
                _CurriculumListTile(subject: '6. Networking Fundamental', credit: '3'),
                // Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '7. Web Development I ( Web Design )', credit: '3'),
                _CurriculumListTile(subject: '8. Data Structure and Algorithm', credit: '3'),
                _CurriculumListTile(subject: '9. Database Management Systems', credit: '3'),
                _CurriculumListTile(subject: '10. Intensive English Program II ( For IT Researching )', credit: '3'),
                _CurriculumListTile(subject: '11. Mathematics ( Discrete Math )', credit: '3'),
                _CurriculumListTile(subject: '12. System Administration', credit: '3'),
                // Divider(),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.defaultWhiteColor,
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1), // Add bottom border
              ),
            ),
            child: const ExpansionTile(
              title: Text(
                'Year 2',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '13. Application Security (Cybersecurity)', credit: '3'),
                _CurriculumListTile(subject: '14. Web Development II (Java, Spring Framework)', credit: '4'),
                _CurriculumListTile(subject: '15. Object Oriented Analysis and Design', credit: '3'),
                _CurriculumListTile(subject: '16. Mathematics II (Business Statistics)', credit: '3'),
                _CurriculumListTile(subject: '17. Web Development III (Full Stack Web Development)', credit: '4'),
                _CurriculumListTile(subject: '18. UX and UI Design Professional', credit: '3'),
                // Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '19. Project Management', credit: '3'),
                _CurriculumListTile(subject: '20. Project Practicum ( Internship )', credit: '12'),
                // Divider(),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.defaultWhiteColor,
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: const ExpansionTile(
              title: Text(
                'Year 3',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '21. Database Administration (DBA)', credit: '3'),
                _CurriculumListTile(subject: '22. Ethical Hacking ( Cybersecurity )', credit: '4'),
                _CurriculumListTile(subject: '23. Data Analytics', credit: '4'),
                _CurriculumListTile(subject: '24. Python for Data Analytics', credit: '3'),
                _CurriculumListTile(subject: '25. Application Development I ( .NET Framework )', credit: '3'),
                // Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '26. Mobile Development I', credit: '3'),
                _CurriculumListTile(subject: '27.  Mobile Development II', credit: '3'),
                _CurriculumListTile(subject: '28. Linux System Administration', credit: '3'),
                _CurriculumListTile(subject: '29. DevOps Engineering ( For IT Researching )', credit: '3'),
                _CurriculumListTile(subject: '30. Application Development II ( .NET Framework )', credit: '3'),
                _CurriculumListTile(subject: '31. Soft Skill ( Career Preparation, Teamwork, Interpersonal )', credit: '2'),
                // Divider(),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.defaultWhiteColor,
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: const ExpansionTile(
              title: Text(
                'Year 4',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '32. Fundamental of Machine Learning', credit: '3'),
                _CurriculumListTile(subject: '33. Fundamental of Artificial Intelligence', credit: '3'),
                _CurriculumListTile(subject: '34. Software Engineering', credit: '3'),
                _CurriculumListTile(subject: '35. Microservices Architecture ( Spring Framework )', credit: '3'),
                _CurriculumListTile(subject: '36. Application Integration with AI', credit: '3'),
                _CurriculumListTile(subject: '37. Research Methodology ( How to write thesis statement )', credit: '3'),
                // Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Semester 2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _CurriculumListTile(subject: '38. Internship ( Project Practicum II )', credit: '12'),
                // Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _CurriculumListTile extends StatelessWidget {
  final String subject;
  final String credit;

  const _CurriculumListTile({
    Key? key,
    required this.subject,
    required this.credit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(subject, style: const TextStyle(fontSize: 14),),
          trailing: Text(credit),
        ),
        // const Divider(),
      ],
    );
  }
}

const DataCellTextStyle = TextStyle(
  fontSize: 16,
  color: AppColors.defaultGrayColor,
  fontWeight: FontWeight.normal,
);


const DataTableHeaderStyle = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.bold,
  color: AppColors.defaultGrayColor,
);

