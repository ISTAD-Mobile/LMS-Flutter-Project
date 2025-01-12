import 'package:http/http.dart' as http;

class AdmissionService {
  Future<dynamic> postAdmission(url, data) async {
    var headers = {
      'Content-Type' : 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print('Admission service: ${response.statusCode} ');
    } else {
      print(response.reasonPhrase);
    }
  }
}