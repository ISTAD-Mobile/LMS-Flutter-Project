import 'package:flutter/material.dart';
import '../../data/response/api_response.dart';
import '../../repository/admission/upload_image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final _imageRepo = ImageRepository();
  ApiResponse<dynamic> response = ApiResponse();

  void setImageData(response) {
    this.response=response;
    print('Upload Image Response ${response}');
    notifyListeners();
  }

  Future<dynamic> uploadFileImage(image) async {
    setImageData(ApiResponse.loading());
    print('Upload Image: ${ApiResponse}');
    await _imageRepo.uploadImageFile(image)
        .then((imageList) => setImageData(ApiResponse.completed(imageList)))
        .onError((error,strackTrace) => setImageData(ApiResponse.error(strackTrace.toString())));
  }

}
