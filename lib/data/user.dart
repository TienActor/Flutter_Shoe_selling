class User {
  String idNumber;
  String accountId;
  String fullName;
  String phoneNumber;
  String imageURL;
  String birthDay;
  String gender;
  String schoolYear;
  String schoolKey;
  String dateCreated;
  bool status;
  List<String> addresses;

  User({
    required this.idNumber,
    required this.accountId,
    required this.fullName,
    required this.phoneNumber,
    required this.imageURL,
    required this.birthDay,
    required this.gender,
    required this.schoolYear,
    required this.schoolKey,
    required this.dateCreated,
    required this.status,
    required this.addresses,
  });

  static User userEmpty() {
    return User(
      idNumber: '',
      accountId: '',
      fullName: '',
      phoneNumber: '',
      imageURL: '',
      birthDay: '',
      gender: '',
      schoolYear: '',
      schoolKey: '',
      dateCreated: '',
      status: false,
      addresses: [],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        idNumber: json["idNumber"] ?? '',
        accountId: json["accountID"] ?? '',
        fullName: json["fullName"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        imageURL: json["imageURL"] ?? '',
        birthDay: json["birthDay"] ?? '',
        gender: json["gender"] ?? '',
        schoolYear: json["schoolYear"] ?? '',
        schoolKey: json["schoolKey"] ?? '',
        dateCreated: json["dateCreated"] ?? '',
        status: json["status"] ?? false,
        addresses: List<String>.from(json["addresses"] ?? []),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNumber'] = idNumber;
    data['accountID'] = accountId;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['imageURL'] = imageURL;
    data['birthDay'] = birthDay;
    data['gender'] = gender;
    data['schoolYear'] = schoolYear;
    data['schoolKey'] = schoolKey;
    data['addresses'] = addresses;

    return data;
  }
}


class UserAddress {
  final List<String> addresses;

  UserAddress({required this.addresses});

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      addresses: List<String>.from(json['addresses']),
    );
  }
}

class UserData {
  final String email;
  final String phone;
  final List<String> addresses;

  UserData({
    required this.email,
    required this.phone,
    required this.addresses,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      phone: json['phone'],
      addresses: List<String>.from(json['addresses']),
    );
  }
}
