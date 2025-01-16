import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UploadApiImage {
  Future<Map<String, dynamic>?> uploadImage(Uint8List bytes, String name) async {
    Uri url = Uri.parse("https://dev-flutter.cstad.edu.kh/api/v1/portals/uploads");

    var request = http.MultipartRequest("POST", url);

    request.headers.addAll({
      "Accept": "application/json",
    });

    var myFile = http.MultipartFile(
      "file",
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: name,
      contentType: MediaType("image","jpg"),
    );
    request.files.add(myFile);
    final response = await request.send();

    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 201) {
      var data = await response.stream.bytesToString();
      print('Response Body: $data');
      Map<String, dynamic> responseBody = jsonDecode(data);
      return responseBody;
    } else {
      var errorResponse = await response.stream.bytesToString();
      print('Error Response: $errorResponse');
      return null;
    }
  }
}
