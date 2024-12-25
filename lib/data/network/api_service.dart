import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lms_mobile/data/network/app_exception.dart';

class ApiService {

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


  Future<dynamic> postAdmission(url , data) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201){
      print(await response.stream.bytesToString());
    }
    else{
      print(response.reasonPhrase);
    }
  }
}
