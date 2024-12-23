import 'package:flutter/material.dart';
import 'package:lms_mobile/data/color/color_screen.dart';

import '../../enrollments/enroll_screen.dart';

class CourseDetailsPage extends StatelessWidget {
  final List<CourseSection> sections = [
    CourseSection(
      title: 'INTRODUCTION TO DATA ANALYTICS',
      topics: [
        'What is Data Analytic',
        'Data Analysis Steps',
        'Type of Data Analytics',
        'Data Analytics Use Cases',
        'Lifecycle of Data Analytics',
        'Benefits of Data Analytic',
        'Data Analytics Techniques',
        'Data Analytics Tools',
        'How to become a Data Analyst?',
        'Skills needed to become a data analyst',
        'Data Analytics Techniques',
      ],
    ),
    CourseSection(
      title: 'EXCEL FOR DATA ANALYTICS',
      topics: [
        'Data preparation with Excel Sheet, (Extraction)',
        'Data Warehouse (Load, find the missing value, invalid data)',
        'Data Transformation and Data Analyze',
        'Data Visualization (chart, statistics)'
      ],
    ),
    CourseSection(
      title: 'PYTHON WITH LIBRARIES TO USE IN DATA ANALYTIC',
      topics: [
        'Installation Python',
        'Tool to use (Jupyter)',
        'Array',
        'Matrix Operation',
        'Dictionaries',
        'Dataframe of Pandas with Python',
        'Series of Pandas with Python',
        'Dynamic Array of Numpy with Python',
      ],
    ),
    CourseSection(
      title: 'SQL FOR DATA ANALYTIC',
      topics: [
        'Introduction to SQL',
        'Database Normalization and Entity Relationship Model',
        'SQL Operators',
        'Working with SQL',
      ],
    ),
    CourseSection(
      title: 'BUSINESS CASE STUDIES AND REPORT AND STORYTELLING',
      topics: [
        'Understanding Business domains',
        'Understanding the business problem and formulating hypotheses',
        'Exploratory data analysis',
        'Data storytelling',
        'Project on deriving business insights and storytelling',
      ],
    ),
    CourseSection(
      title: 'BUSINESS CASE STUDIES',
      topics: [
        'Real world Business Analytics',
        'Focus on Real world problem',
        'Business Required',
        'Answer to business question',
        'Predictive Model based on Real Requirement',
        'Practice to Build a Model and Generate the Report',
      ],
    ),
    CourseSection(
      title: 'PREDICTIVE MODELING',
      topics: [
        'Build model to analyze following defined questions of business',
      ],
    ),
    CourseSection(
      title: 'DATA WAREHOUSE (READY DATA TO ANALYZE)',
      topics: [
        'Data Warehouse Concept',
        'Type of Data Warehouse',
        'Data Warehouse architecture',
        'Data Warehouse Characteristics',
        'Data Warehouse vs Database',
        'Create a Data Warehouse from a sample raw data',
      ],
    ),
    CourseSection(
      title: 'TABLEAU',
      topics: [
        'Introduction to Data Visualization and The Power of Tableau',
        'Architecture of Tableau',
        'Charts and Graphs',
        'Working with Metadata and Data Blending',
        'Advanced Data Manipulations',
        'Organizing Data and Visual Analytics to report to Business owner',
      ],
    ),
    CourseSection(
      title: 'FINAL PROJECT',
      topics: [
        'Topic will be provided',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.defaultWhiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.defaultGrayColor),
        ),
        title: const Text("Course Description",
          style: TextStyle(fontSize: 16, color: AppColors.primaryColor),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DATA ANALYTIC',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Data Analytics is the process of analyzing raw data sets of the techniques and processes of data analytics have been automated into mechanical processes and algorithms.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.defaultGrayColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'COURSE OFFER',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 2.0,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildCourseOffers(),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              _buildPriceSection(),
              const SizedBox(height: 16),
              _buildResetButton(context),
              const SizedBox(height: 16),
              ...sections.map((section) => _buildExpansionTile(section))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseOffers() {
    final offers = [
      '1. Introduction to Data Analytics',
      '2. Excel for Data Analytics',
      '3. Python with Libraries to use in Data\nAnalytics',
      '4. SQL for Analytics',
      '5. Business Problem Solving, Insights\nand Storytelling',
      '6. Business Case Studies',
      '7. Predictive Modeling',
      '8. Data Warehouse',
      '9. Tableau',
      '10. Final Project',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: offers.map((offer) =>
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(offer, style: const TextStyle(fontSize: 14,)),
              ],
            ),
          )).toList(),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  '20% Off',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\$1200.0 ',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '  /  \$960.0',
                      style: TextStyle(
                        color: AppColors.defaultBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Duration: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.defaultBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' 4 months',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => EnrollScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Enroll',
          style: TextStyle(
            color: AppColors.defaultWhiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(CourseSection section) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                section.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              // backgroundColor: Colors.blue,
              collapsedBackgroundColor: Colors.white,
              iconColor: AppColors.primaryColor,
              collapsedIconColor: Colors.blue[900],
              tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              childrenPadding: EdgeInsets.all(0),
              expandedAlignment: Alignment.topLeft,
              maintainState: true,
              onExpansionChanged: (expanded) {
                setState(() {});
              },
              trailing: const Icon(Icons.arrow_drop_down),
              leading: Icon(Icons.menu_book_outlined, color: Colors.blue[900]),
              initiallyExpanded: false,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: section.topics.map((topic) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 6),
                                child: Icon(Icons.circle, size: 6,
                                    color: Colors.grey[600]),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  topic,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

  class CourseSection {
  final String title;
  final List<String> topics;

  CourseSection({
    required this.title,
    required this.topics,
  });
}

