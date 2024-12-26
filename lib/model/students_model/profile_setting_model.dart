import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  List<Content> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int numberOfElements;
  bool first;
  int size;
  int number;
  Sort sort;
  bool empty;

  ProfileModel({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.numberOfElements,
    required this.first,
    required this.size,
    required this.number,
    required this.sort,
    required this.empty,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    last: json["last"],
    numberOfElements: json["numberOfElements"],
    first: json["first"],
    size: json["size"],
    number: json["number"],
    sort: Sort.fromJson(json["sort"]),
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "pageable": pageable.toJson(),
    "totalPages": totalPages,
    "totalElements": totalElements,
    "last": last,
    "numberOfElements": numberOfElements,
    "first": first,
    "size": size,
    "number": number,
    "sort": sort.toJson(),
    "empty": empty,
  };
}

class Content {
  String uuid;
  String? cardId;
  int studentStatus;
  String profileImage;
  String? nameEn;
  String? nameKh;
  Gender? gender;
  String? email;
  String username;
  String? phoneNumber;
  String guardianRelationShip;
  String? familyPhoneNumber;
  String? birthPlace;
  String? currentAddress;
  String biography;
  DateTime dob;
  BacIiGrade bacIiGrade;
  String highSchoolCertificate;
  String? vocationTrainingCertificate;
  String? anyValuableCertificate;

  Content({
    required this.uuid,
    required this.cardId,
    required this.studentStatus,
    required this.profileImage,
    required this.nameEn,
    required this.nameKh,
    required this.gender,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.guardianRelationShip,
    required this.familyPhoneNumber,
    required this.birthPlace,
    required this.currentAddress,
    required this.biography,
    required this.dob,
    required this.bacIiGrade,
    required this.highSchoolCertificate,
    required this.vocationTrainingCertificate,
    required this.anyValuableCertificate,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    cardId: json["cardId"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
    email: json["email"] ?? '',
    nameEn: json["nameEn"] ?? '',
    nameKh: json["nameKh"] ?? '',
    uuid: json["uuid"],
    studentStatus: json["studentStatus"],
    profileImage: json["profileImage"],
    gender: genderValues.map[json["gender"]]!,
    username: json["username"],
    guardianRelationShip: json["guardianRelationShip"],
    familyPhoneNumber: json["familyPhoneNumber"],
    birthPlace: json["birthPlace"],
    currentAddress: json["currentAddress"],
    biography: json["biography"],
    dob: DateTime.parse(json["dob"]),
    bacIiGrade: bacIiGradeValues.map[json["bacIiGrade"]]!,
    highSchoolCertificate: json["highSchoolCertificate"],
    vocationTrainingCertificate: json["vocationTrainingCertificate"],
    anyValuableCertificate: json["anyValuableCertificate"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "cardId": cardId,
    "studentStatus": studentStatus,
    "profileImage": profileImage,
    "nameEn": nameEn,
    "nameKh": nameKh,
    "gender": genderValues.reverse[gender],
    "email": email,
    "username": username,
    "phoneNumber": phoneNumber,
    "guardianRelationShip": guardianRelationShip,
    "familyPhoneNumber": familyPhoneNumber,
    "birthPlace": birthPlace,
    "currentAddress": currentAddress,
    "biography": biography,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "bacIiGrade": bacIiGradeValues.reverse[bacIiGrade],
    "highSchoolCertificate": highSchoolCertificate,
    "vocationTrainingCertificate": vocationTrainingCertificate,
    "anyValuableCertificate": anyValuableCertificate,
  };
}

enum BacIiGrade {
  A,
  B,
  C
}

final bacIiGradeValues = EnumValues({
  "A": BacIiGrade.A,
  "B": BacIiGrade.B,
  "C": BacIiGrade.C
});

enum Gender {
  F,
  M
}

final genderValues = EnumValues({
  "F": Gender.F,
  "M": Gender.M
});

class Pageable {
  int pageNumber;
  int pageSize;
  Sort sort;
  int offset;
  bool paged;
  bool unPaged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unPaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    sort: Sort.fromJson(json["sort"]),
    offset: json["offset"],
    paged: json["paged"],
    unPaged: json["unpaged"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "sort": sort.toJson(),
    "offset": offset,
    "paged": paged,
    "unpaged": unPaged,
  };
}

class Sort {
  bool unsorted;
  bool sorted;
  bool empty;

  Sort({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    unsorted: json["unsorted"],
    sorted: json["sorted"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "unsorted": unsorted,
    "sorted": sorted,
    "empty": empty,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
