class ProductModel{
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  // dau ? cho phep null 
  ProductModel({this.id,this.name,this.price,this.img,this.des});
}

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



class User{
  String? fullname;
  String? email;
  String? gender;
  String? favorite;


  // default contructor
  User({this.fullname,this.email,this.gender,this.favorite});
}