import '../data/network/api_service.dart';
import '../model/upload_image.dart';
import '../resource/app_url.dart';

class ImageRepository{
  final _apiService = ApiService();

  Future<UploadImageResponse> uploadImageFile(image) async {
    var response = await _apiService.uploadImage(image,UploadImageUrl.uploadImagebaseUrl);
    return uploadImageResponseFromJson(response);
  }
}

