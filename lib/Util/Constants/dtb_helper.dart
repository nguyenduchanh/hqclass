class DBHelper {
  static const api_url_v1 = "http://10.1.3.136";

  // user api
  static const login_url = api_url_v1 + "user/login";

  //get class api
  static const class_url = ":9999/v1/classes";

  //get user api
  static const user_url = ":9999/v1/users";

  //get student api
  static const student_url = ":9999/v1/students";

  //export student api
  static const export_student_url = ":9999/v1/students/export";
  //export classes api
  static const export_classes_url = ":9999/v1/classes/export";
  //export user api
  static const export_user_url = ":9999/v1/user/export";
}
