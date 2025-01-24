
import 'package:lms_mobile/resource/app_url.dart';

import '../../data/network/api_service.dart';
import '../../model/admission/upload_image.dart';

class ImageRepository{
  final _apiService = ApiService();

  Future<UploadImageResponse> uploadImageFile(image) async {
    var response = await _apiService.uploadImage(image,ApiUrl.postImageByUrl);
    return uploadImageResponseFromJson(response);
  }

}

