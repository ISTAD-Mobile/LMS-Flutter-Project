import 'dart:convert';

UploadImageResponse uploadImageResponseFromJson(String str) => UploadImageResponse.fromJson(json.decode(str));

String uploadImageResponseToJson(UploadImageResponse data) => json.encode(data.toJson());

class UploadImageResponse {
  String? name;
  String? contentType;
  String? extension;
  String? uri;
  int? size;

  UploadImageResponse({
    this.name,
    this.contentType,
    this.extension,
    this.uri,
    this.size,
  });

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) => UploadImageResponse(
    name: json["name"],
    contentType: json["contentType"],
    extension: json["extension"],
    uri: json["uri"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contentType": contentType,
    "extension": extension,
    "uri": uri,
    "size": size,
  };
}
