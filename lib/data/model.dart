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

class SignupModel {
  String? _accountID;
  String? _password;
  String? _confpass;
  String? _fullname;
  String? _numberID;
  String? _phoneNumber;
  String? _gender;
  String? _birthday;
  String? _schoolYear;
  String? _schoolKey;
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

  String? get schoolYear => _schoolYear;
  set schoolYear(String? value) => _schoolYear = value?.trim();

  String? get schoolKey => _schoolKey;
  set schoolKey(String? value) => _schoolKey = value?.trim();

  String? get urlImage => _urlImage;
  set urlImage(String? value) => _urlImage = value?.trim() ??
      "https://media.istockphoto.com/id/1409715003/vector/man-avatar-placeholder-icon-design.jpg?s=612x612&w=0&k=20&c=Lk44BhYJIOpbSCYkymK0GGuziooahH0Mo_2Gzpzuw2Q=";
}
