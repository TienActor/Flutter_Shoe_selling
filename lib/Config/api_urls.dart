class ApiUrls {
  static const String login = "https://huflit.id.vn:4321/api/Auth/login";
  static const String register = "https://huflit.id.vn:4321/api/Student/signUp";
  static const String updateInfo =
      "https://huflit.id.vn:4321/api/Auth/updateProfile";
  static const String changPassword =
      "https://huflit.id.vn:4321/api/Auth/ChangePassword";
  static const String forgotPassword =
      "https://huflit.id.vn:4321/api/Auth/forgetPass";
  static const String getListProduct =
      "https://huflit.id.vn:4321/api/Product/getList?accountID=Tie2023";
  static const String getListByCatId =
      "https://huflit.id.vn:4321/api/Product/getListByCatId?categoryID=1&accountID=Tie2023";
  static const String addBill = "https://huflit.id.vn:4321/api/Order/addBill";
  static const String getBillById =
      "https://huflit.id.vn:4321/api/Bill/getByID?billID=";
  static const String getBillHistory =
      "https://huflit.id.vn:4321/api/Bill/getHistory";
  static const String removeBill =
      "https://huflit.id.vn:4321/api/Bill/remove?billID=";

  // lưu ý dùng thêm share preferent để lưu token khi đăng nhập để xác minh các phần sửa thông tin tài khoản , quên mật khẩu
}
