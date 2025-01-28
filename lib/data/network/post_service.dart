import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _client = http.Client();

  Future<dynamic> post(String url, String body, {Map<String, String>? header}) async {
    try {
      final response = await _client.post(Uri.parse(url),
          headers: header ?? {}, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}


class EnrollStep2Service {
  final ApiService _apiServices = ApiService();

  Future<dynamic> postEnrollmentStep2(String url, Map<String, dynamic> data) async {
    final header = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var body = json.encode(data);
    var response = await _apiServices.post(url, body, header: header);
    return response;
  }
}

class EnrollService {
  final ApiService _apiServices = ApiService();

  Future<dynamic> postEnrollment(String url, Map<String, dynamic> data) async {
    final header = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var body = json.encode(data);
    var response = await _apiServices.post(url, body, header: header);
    return response;
  }
}



class AdmissionService {
  final ApiService _apiServices = ApiService();

  Future<dynamic> postAdmission(String url, Map<String, dynamic> data) async {
    final header = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var body = json.encode(data);
    var response = await _apiServices.post(url, body, header: header);
    return response;
  }
}

