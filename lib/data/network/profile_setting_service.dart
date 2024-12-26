import 'dart:io';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ProfileSettingService {

  Future<dynamic> getProfileSettingApiService(url) async {
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

}