class ApiConfig {
  @override
  noSuchMethod(Invocation invocation) async {
    return super.noSuchMethod(invocation);
  }

 // final key_auth = 'Authorization';
  final x_api_key = 'X-API-KEY';
  final x_api_key_value = 'AYTWEB@12345678';

  final content_type = 'Authorization';
  final content_type_value = 'Basic YXl0YWRtaW46MTIzNDU2Nzg=';
  //final key_auth_value =
      //'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGVjaG5vbGl0ZS5pblwvc3RhZ2luZ1wvbWVkaGF2aVwvYXBpXC9sb2dpbiIsImlhdCI6MTYzNjk2NDY4OCwiZXhwIjoxNjM2OTY4Mjg4LCJuYmYiOjE2MzY5NjQ2ODgsImp0aSI6Ilc3cTFieVN5b1NyanRYTUMiLCJzdWIiOjEwLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.kRWE52JhIpMonIgmDLBt2bcr1gq4FYgaqIzKsrfrnF8';
  final slider_img_path = "uploads/slider/";

  final employee_expense_img_path = "/uploads/employee_expense/";

  final profile_img_path = "/uploads/employee/";

  String baseurl = "http://taxrgs.adiyogitechnology.com/api/";

  String baseurl_img = "https://technolite.in/staging/easyhomecare/";

  String api_login = "login";
  String api_setting = "setting";
  String api_forgot_password = "forgot-password";

  String api_reset_password = "reset-password";
  String api_change_password = "change-password";
  String api_dashboard = "get-dashboard";
  String api_categorylist = "get-category-list";
  String api_videolistcategorylist = "get-videolist-by-category/";
  String api_notificationlist = "notification-list";
  String api_cmspg = "cms/";


  String api_register = "registration";

  String api_get_all_booking = "getbookings?driver_id=";

 // String api_get_profile = "employee";

  String api_update_profile = "employee_update";
  String api_updated_profile = "employee/";
}
