import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AssociatePage(),
  ));
}

class AssociatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text("Associate Program",style: TextStyle(fontSize: 16),),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  // borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // Background Image
                      Image.asset(
                        'assets/images/IT_expert_gen1.png',
                        height: 230,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // Semi-transparent Overlay
                      Container(
                        height: 230,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Text
                      const Text(
                        'Associate Program',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8), // Spacing between text
                      // Subtitle Text
                      const Text(
                        'ISTAD aim to provide a 10 months training\n'
                            'to become a IT specialist.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16), // Spacing before button
                      // Enroll Button
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Enroll Now' , style: TextStyle(color: AppColors.defaultWhiteColor,fontWeight: FontWeight.normal),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16), // Adjust padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Program Overview
                  const Text(
                    'Program Overview',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The primary purpose of developing this modern Information Technology (IT) curriculum is to bridge the gap between traditional academic education and the ...',
                    style: TextStyle(fontSize: 16,color: AppColors.defaultGrayColor),
                  ),
                  const SizedBox(height: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FUTURE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: AppColors.secondaryColor,
                          height: 1,
                        ),
                      ),
                      Text(
                        'CAREER',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.transparent,
                      border: Border.all(color: AppColors.primaryColor,width: 1.0),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "អាជីពការងារដែលនិស្សិតអាចទទួលបានក្រោយបញ្ចប់ការសិក្សា៖",
                          style: TextStyle(fontSize: 16, color: AppColors.defaultGrayColor),
                        ),
                        const SizedBox(height: 10),
                        ...[
                          '• UI and UX Designer',
                          '• Web Developer',
                          '• Software Developer',
                          '• IT Technician',
                          '• Frontend Developer',
                          '• Backend Developer',
                          '• Full Stack Developer',
                          '• Penetration Tester',
                          '• Security Analyst',
                          '• Application Security Engineer',
                          '• System Administrator',
                        ].map((career) => Text(
                          career,
                          style: const TextStyle(fontSize: 16, color: AppColors.defaultGrayColor),
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROGRAM STRUCTURE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor,
                          height: 1,
                        ),
                      ),
                      Text(
                        'CURRICULUM',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
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
                        Divider(),
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
                        Divider(),
                      ],
                    ),
                  ),

                  Container(
                    decoration: const BoxDecoration(
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
                        Divider(),
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
                        Divider(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ASSESSMENT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentColor,
                          // height: 1,
                        ),
                      ),
                      Text(
                        'EVALUATION & GRADUATION',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    color: AppColors.accentColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Score', style: TextStyle(fontSize: 20))),
                            DataColumn(label: Text('GPA', style: TextStyle(fontSize: 20))),
                            DataColumn(label: Text('Grade', style: TextStyle(fontSize: 20))),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(Text('85-100')),
                              DataCell(Text('4.0')),
                              DataCell(Text('A')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('80-84')),
                              DataCell(Text('3.5')),
                              DataCell(Text('B+')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('70-79')),
                              DataCell(Text('3.0')),
                              DataCell(Text('B')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('65-69')),
                              DataCell(Text('2.5')),
                              DataCell(Text('C+')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('50-54')),
                              DataCell(Text('2.0')),
                              DataCell(Text('C')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('45-49')),
                              DataCell(Text('1.5')),
                              DataCell(Text('D')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('0-44')),
                              DataCell(Text('0')),
                              DataCell(Text('F')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )

          ],
        ),
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
        const Divider(), // Horizontal line between subjects
      ],
    );
  }
}