class User {
   String? idNumber;
  String? accountId;
  String? fullName;
  String? phoneNumber;
  String? imageURL;
  String? birthDay;
  String? gender;
  String? schoolYear;
  String? schoolKey;
  String? dateCreated;
  bool? status;

  User({
    this.idNumber,
    this.accountId,
    this.fullName,
    this.phoneNumber,
    this.imageURL,
    this.birthDay,
    this.gender,
    this.schoolYear,
    this.schoolKey,
    this.dateCreated,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idNumber: json['numberID'] as String?,
      accountId: json['accountID'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      imageURL: json['imageUrl'] as String?,  // Lưu ý đây là 'imageUrl' chứ không phải 'imageURL'
      birthDay: json['birthDay'] as String?,
      gender: json['gender'] as String?,
      schoolYear: json['schoolYear'] as String?,
      schoolKey: json['schoolKey'] as String?,
      dateCreated: json['dateCreated'] as String?,
      status: json['active'] as bool?,  // Dùng 'active' thay vì 'status'
    );
  }
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
        status: false);
  }

}
