import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/category.dart';
import '../data/model.dart';
import '../data/product.dart';
import '../data/user.dart';

class ApiUrls {
  final Dio _dio = Dio();

  Dio get sendRequest => _dio;
  static const String baseUrl = "https://huflit.id.vn:4321/api";

  // Auth endpoints
  static const String login = "$baseUrl/Auth/login";
  static const String register = "$baseUrl/Student/signUp";
  static const String updateInfo = "$baseUrl/Auth/updateProfile";
  static const String changePassword = "$baseUrl/Auth/ChangePassword";
  static const String forgotPassword = "$baseUrl/Auth/forgetPass";

  // Product endpoints
  static const String getListProduct =
      "$baseUrl/Product/getList?accountID=Tie2023";
  static const String getListByCatId =
      "$baseUrl/Product/getListByCatId?categoryID=1&accountID=Tie2023";
  static const String updateProduct = "$baseUrl/updateProduct";
  static const String addProduct = "$baseUrl/addProduct";
  static const String deleteProduct = "$baseUrl/removeProduct";
  // Bill endpoints
  static const String addBill = "$baseUrl/Order/addBill";
  static const String getBillById = "$baseUrl/Bill/getByID?billID=";
  static const String getBillHistory = "$baseUrl/Bill/getHistory";
  static const String removeBill = "$baseUrl/Bill/remove?billID=";
}

class APIRepository {
  ApiUrls api = ApiUrls();
  final Dio _dio = Dio();
  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Map<String, dynamic>> signup(SignupModel signupModel) async {
    try {
      final body = FormData.fromMap({
        "numberID": signupModel.numberID,
        "accountID": signupModel.accountID,
        "fullName": signupModel.fullname,
        "phoneNumber": signupModel.phonenumber,
        "imageURL": signupModel.urlImage,
        "birthDay": signupModel.birthday,
        "gender": signupModel.gender,
        "schoolYear": signupModel.schoolYear,
        "schoolKey": signupModel.schoolKey,
        "password": signupModel.password,
        "confirmPassword": signupModel.confirmpass,
      });
      Response res = await api.sendRequest.post(
        ApiUrls.register,
        options: Options(headers: header('no token')),
        data: body,
      );
      log("Response data: ${res.data}");
      if (res.statusCode == 200) {
        final data = res.data;
        if (data['success'] == true) {
          if (data['data'] == "Đăng ký thành công") {
            return {"success": true, "message": data['data']};
          } else if (data['data'] == "AccountID đã tồn tại") {
            return {"success": false, "message": data['data']};
          } else {
            return {"success": false, "message": data['data']};
          }
        } else {
          return {"success": false, "message": data['message']};
        }
      } else {
        return {"success": false, "message": "Đăng ký thất bại"};
      }
    } catch (ex) {
      /* log('Signup exception: $ex'); */
      return {"success": false, "message": "Lỗi: $ex"};
    }
  }

  Future<Map<String, dynamic>> forgetPass(
      String accountID, String numberID, String newPassword) async {
    try {
      final body = FormData.fromMap({
        'accountID': accountID,
        'numberID': numberID,
        'newPass': newPassword,
      });
      Response res = await api.sendRequest.put(
        ApiUrls.forgotPassword,
        options: Options(
          headers: header('no token'),
          validateStatus: (status) {
            return status == 200 || status == 400;
          },
        ),
        data: body,
      );
      log("Response data: ${res.data}");
      if (res.statusCode == 200) {
        final data = res.data;
        if (data['success'] == true) {
          log('Đổi mật khẩu thành công: ${data['data']}');
          return {"success": true, "message": data['data']};
        } else {
          log('Thất bại: ${data['error']}');
          return {"success": false, "message": data['error']};
        }
      } else if (res.statusCode == 400) {
        final data = res.data;
        log('${data['error']}');
        return {'success': false, 'message': data['error']};
      } else {
        log('Đăng ký thất bại với mã trạng thái: ${res.statusCode}');
        return {"success": false, "message": "Đăng ký thất bại"};
      }
    } catch (ex) {
      log('Exception: $ex');
      return {'success': false, 'message': 'Lỗi: $ex'};
    }
  }

  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    try {
      final body = FormData.fromMap({
        'AccountID': loginModel.accountID,
        'Password': loginModel.password,
      });
      Response res = await api.sendRequest.post(
        ApiUrls.login,
        options: Options(
          headers: header('no token'),
          validateStatus: (status) {
            return status == 200 || status == 401 || status == 500;
          },
        ),
        data: body,
      );
      if (res.statusCode == 200) {
        final data = res.data;
        if (data['success'] == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final tokenData = data['data']['token'];
          prefs.setString('token', tokenData);
          prefs.setString('accountID', loginModel.accountID!);
          return {'success': data['success'], 'token': tokenData};
        }
        return {'success': data['success']};
      } else if (res.statusCode == 401) {
        final data = res.data;
        return {'success': data['success'], 'message': data['error']};
      } else if (res.statusCode == 500) {
        return {'success': false, 'message': 'Tài khoản không tồn tại'};
      } else {
        return {'success': false, 'message': '${res.statusCode}'};
      }
    } catch (ex) {
      print(ex);
      return {'success': false, 'message': 'Lỗi: $ex'};
    }
  }

  Future<User> current(String token) async {
    try {
      Response res = await api.sendRequest
          .get('/Auth/current', options: Options(headers: header(token)));
      return User.fromJson(res.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategory(
      String accountID, String token) async {
    try {
      Response res = await Dio().get(
        '${ApiUrls.baseUrl}/Category/getList?accountID=$accountID',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return res.data
          .map((e) => CategoryModel.fromJson(e))
          .cast<CategoryModel>()
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  // Future<bool> addCategory(
  //     CategoryModel data, String accountID, String token) async {
  //   try {
  //     final body = FormData.fromMap({
  //       'name': data.name,
  //       'description': data.desc,
  //       'imageURL': data.imageUrl,
  //       'accountID': accountID
  //     });
  //     Response res = await api.sendRequest.post('/addCategory',
  //         options: Options(headers: header(token)), data: body);
  //     if (res.statusCode == 200) {
  //       print("ok add category");
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
  // }

  // Future<bool> updateCategory(int categoryID, CategoryModel data,
  //     String accountID, String token) async {
  //   try {
  //     final body = FormData.fromMap({
  //       'id': categoryID,
  //       'name': data.name,
  //       'description': data.desc,
  //       'imageURL': data.imageUrl,
  //       'accountID': accountID
  //     });
  //     Response res = await api.sendRequest.put('/updateCategory',
  //         options: Options(headers: header(token)), data: body);
  //     if (res.statusCode == 200) {
  //       print("ok update category");
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
  // }

  // Future<bool> removeCategory(
  //     int categoryID, String accountID, String token) async {
  //   try {
  //     final body =
  //         FormData.fromMap({'categoryID': categoryID, 'accountID': accountID});
  //     Response res = await api.sendRequest.delete('/removeCategory',
  //         options: Options(headers: header(token)), data: body);
  //     if (res.statusCode == 200) {
  //       print("ok remove category");
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
  // }

  Future<List<ProductModel>> fetchProducts(
      String accountID, String token) async {
    Response res = await api.sendRequest.get(
        "${ApiUrls.getListProduct}&accountID=$accountID",
        options: Options(headers: header(token)));
    List<dynamic> data = res.data;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> fetchFavoriteProducts(
      String accountID, List<String> favoriteIds, String token) async {
    if (favoriteIds.isEmpty) {
      return []; // Return an empty list if no favorite IDs are present
    }

    // Building the query parameters correctly
    String queryParameters =
        favoriteIds.map((id) => 'id=${Uri.encodeComponent(id)}').join('&');
    // Ensure the URL is correctly formed with query parameters
    String url = "${ApiUrls.getListProduct}&$queryParameters";

    try {
      Response res = await api.sendRequest
          .get(url, options: Options(headers: header(token)));

      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load favorite products: ${res.statusCode}');
      }
    } catch (e) {
      print('Error fetching favorite products: $e');
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsCat(
      String accountID, String token, String idCat) async {
    Response res = await api.sendRequest.get(
        "${ApiUrls.getListByCatId}?categoryID=$idCat&accountID=$accountID",
        options: Options(headers: header(token)));
    List<dynamic> data = res.data;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  // Future<List<ProductModel>> getProductAdmin(String accountID, String token) async {
  //   try {
  //     Response res = await api.sendRequest.get(
  //         '/Product/getListAdmin?accountID=$accountID',
  //         options: Options(headers: header(token)));
  //     return res.data
  //         .map((e) => ProductModel.fromJson(e))
  //         .cast<ProductModel>()
  //         .toList();
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
  // }
  Future<bool> addProduct(ProductModel data, String token) async {
    try {
      final body = FormData.fromMap({
        'name': data.name,
        'description': data.description,
        'imageURL': data.imageURL,
        'Price': data.price,
        'CategoryID': data.categoryID
      });
      Response res = await api.sendRequest.post(ApiUrls.addProduct,
          options: Options(headers: header(token)), data: body);
      if (res.statusCode == 200) {
        print("ok add product");
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<bool> updateProduct(
      ProductModel data, String accountID, String token) async {
    try {
      final body = FormData.fromMap({
        'id': data.id,
        'name': data.name,
        'description': data.description,
        'imageURL': data.imageURL,
        'price': data.price,
        'categoryID': data.categoryID,
        'accountID': accountID
      });
      Response res = await _dio.put(ApiUrls.updateProduct,
          options: Options(headers: header(token)), data: body);
      if (res.statusCode == 200) {
        print("ok update product");
        return true;
      } else {
        print("Failed to update product: ${res.statusCode}");
        return false;
      }
    } catch (ex) {
      print("Error updating product: $ex");
      rethrow;
    }
  }

  Future<bool> removeProduct(
      int productID, String accountID, String token) async {
    try {
      final body =
          FormData.fromMap({'productID': productID, 'accountID': accountID});
      Response res = await api.sendRequest.delete(ApiUrls.deleteProduct,
          options: Options(headers: header(token)), data: body);
      if (res.statusCode == 200) {
        print("ok remove product");
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  // Future<bool> addBill(List<Cart> products, String token) async {
  //   var list = [];
  //   try {
  //     for (int i = 0; i < products.length; i++) {
  //       list.add({
  //         'productID': products[i].productID,
  //         'count': products[i].count,
  //       });
  //     }
  //     Response res = await api.sendRequest.post('/Order/addBill',
  //         options: Options(headers: header(token)), data: list);
  //     if (res.statusCode == 200) {
  //       print("add bill ok");
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
  // }

  // Future<List<BillModel>> getHistory(String token) async {
  //   try {
  //     Response res = await api.sendRequest
  //         .get('/Bill/getHistory', options: Options(headers: header(token)));
  //     return res.data
  //         .map((e) => BillModel.fromJson(e))
  //         .cast<BillModel>()
  //         .toList();
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
  // }

  // Future<List<BillDetailModel>> getHistoryDetail(
  //     String billID, String token) async {
  //   try {
  //     Response res = await api.sendRequest.post('/Bill/getByID?billID=$billID',
  //         options: Options(headers: header(token)));
  //     return res.data
  //         .map((e) => BillDetailModel.fromJson(e))
  //         .cast<BillDetailModel>()
  //         .toList();
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
}
