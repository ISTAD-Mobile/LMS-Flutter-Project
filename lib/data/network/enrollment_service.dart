
import 'package:http/http.dart' as http;

class EnrollmentService {
  //POST ENROLL
  Future<dynamic> postEnrollment(url, data) async {
    var headers = {
      'Content-Type' : 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}