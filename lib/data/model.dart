class LoginModel {
  String? _accountID;
  String? _password;

  String? get accountID => _accountID;
  set accountID(String? value) => _accountID = value?.trim();

  String? get password => _password;
  set password(String? value) => _password = value?.trim();

  LoginModel({String? accountID, String? password})
      : _accountID = accountID,
        _password = password;
}

// model trang đăng kí tài khoản
class RegisterModel {
  String? _accountID;
  String? _password;
  String? _confpass;
  String? _fullname;
  String? _numberID;
  String? _phoneNumber;
  String? _gender;
  String? _birthday;
  String? _schoolkey;
  String? _schoolyear;
  String? _urlImage;

  String? get accountID => _accountID;
  set accountID(String? value) => _accountID = value?.trim();
  String? get password => _password;
  set password(String? value) => _password = value?.trim();
  String? get confirmpass => _confpass;
  set confirmpass(String? value) => _confpass = value?.trim();
  String? get fullname => _fullname;
  set fullname(String? value) => _fullname = value?.trim();
  String? get numberID => _numberID;
  set numberID(String? value) => _numberID = value?.trim();
  String? get phonenumber => _phoneNumber;
  set phonenumber(String? value) => _phoneNumber = value?.trim();
  String? get gender => _gender;
  set gender(String? value) => _gender = value?.trim();
  String? get birthday => _birthday;
  set birthday(String? value) => _birthday = value?.trim();
  String? get schoolKey => _schoolkey;
  set schoolKey(String? value) => _schoolkey = value?.trim();
  String? get schoolYear => _schoolyear;
  set schoolyear(String? value) => _schoolyear = value?.trim();
  String? get urlImage => _urlImage;
  set urlImage(String? value) => _urlImage = value?.trim();

  /// contructor
  RegisterModel({
    String? accountID,
    String? password,
    String? confirmpass,
    String? fullname,
    String? numberID,
    String? phonenumber,
    String? gender,
    String? birthday,
    String? schoolYear,
    String? schoolKey,
  })  : _accountID = accountID,
        _password = password,
        _confpass = confirmpass,
        _fullname = fullname,
        _numberID = numberID,
        _phoneNumber = phonenumber,
        _gender = gender,
        _birthday = birthday,
        _schoolyear = schoolYear,
        _schoolkey = schoolKey;
}

// model category, getlist
class CategoryModel {
  int? id;
  String? name;
  String? imageURL;
  String? description;

  CategoryModel({this.id, this.name, this.imageURL, this.description});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageURL = json['imageURL'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageURL'] = imageURL;
    data['description'] = description;
    return data;
  }
}
