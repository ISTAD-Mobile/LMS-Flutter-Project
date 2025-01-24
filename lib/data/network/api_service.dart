import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/data/network/app_exception.dart';

class ApiService {

  Future<dynamic> getApiService(url) async {
    http.StreamedResponse? response;
    try{
      var request = http.Request('GET', Uri.parse(url));
      response = await request.send();
      var data = await returnResponse(response);
      return data;
    }on SocketException {
      throw FetchDataException(response!.reasonPhrase.toString());
    }
  }

  returnResponse(http.StreamedResponse response ) async {
    switch (response.statusCode) {
      case 200:{
        return await response.stream.bytesToString();
      }
      case 500:
    }
  }


  Future<dynamic> postAdmission(url,data) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }

  }

  Future<dynamic> uploadImage(File image, String uri) async {
    http.StreamedResponse? response;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(uri));

      // Add image to the multipart request
      request.files.add(await http.MultipartFile.fromPath('files', image.path));

      response = await request.send();

      // Check if the response was successful
      return await returnResponse(response);
    } on Exception catch (e) {
      throw FetchDataException("Error uploading image: $e");
    }
  }
}
