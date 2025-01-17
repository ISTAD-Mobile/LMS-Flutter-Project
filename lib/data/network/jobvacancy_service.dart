import 'package:http/http.dart' as http;

class JobvacancyService {
  final String apiKey = '2uHG3FbYCvrZrT2JKRfgPBrfIax5zPwl';

  Future<String> getApiJobvacancy(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'apiKey': apiKey,
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}

