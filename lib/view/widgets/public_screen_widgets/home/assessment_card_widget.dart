import 'package:flutter/material.dart';

class GradingCardScreen extends StatelessWidget {
  const GradingCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SizedBox(
            // Define custom card width and height
            width: screenSize.width * 0.9, // 90% of the screen width
            height: screenSize.height * 0.8, // 80% of the screen height
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            "ASSESSMENT",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "EVALUATION & GRADUATION",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Table Section
                    Expanded(
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        children: [
                          // Header Row
                          TableRow(
                            decoration: const BoxDecoration(
                                color: Colors.red,
                            ), // Light gray background
                            children: [
                              _buildTableHeader("SCORE"),
                              _buildTableHeader("GPA"),
                              _buildTableHeader("GRADE"),
                            ],
                          ),
                          // Data Rows
                          ..._gradingData.map((row) {
                            return TableRow(
                              children: row.map((cell) {
                                return _buildTableCell(cell);
                              }).toList(),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to build header cells
  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Helper to build data cells
  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Grading data
  List<List<String>> get _gradingData => [
    ["85-100", "4.0", "A"],
    ["80-84", "3.5", "B+"],
    ["70-79", "3.0", "B"],
    ["65-69", "2.5", "C+"],
    ["50-54", "2.0", "C"],
    ["45-49", "1.5", "D"],
    ["0-44", "0", "F"],
  ];
}
