class CommonString {
  static const cLoginTitle = "Đăng nhập";
  static const cYourEmail = "Email";
  static const cPassword = "Mật khẩu";
  static const cWelcomeString = "HQ CLASS";
  static const cSignUpTitle = "Đăng ký";

//Title
  static const cMainTitle = "HQ CLASS";
  static const cClassTitle = "Danh sách lớp học";
  static const cStudentTitle = "Danh sách học sinh";
  static const cAddStudentTitle = "Gán học sinh";
  static const cUserInfoTitle = "Thông tin người dùng";
  static const cRegisterTitle = "Đăng ký tài khoản";

// Nav
  static const cSignOutNav = "Đăng xuất";
  static const cStudentNav = "Học sinh";
  static const cClassNav = "Lớp học";
  static const cRollUpNav = "Điểm danh";
  static const cHomePageNav = "Báo cáo";
  static const cUserInfoNav = "Thông tin người đùng";
  static const cBackupPageNav = "Cập nhật dữ liệu";

//Login page
  static const cEnterPassword = "Nhập mật khẩu";
  static const cPasswordPlaceHolder = "Nhập mật khẩu";
  static const cConfirmPassword = "Xác nhận mật khẩu";
  static const cForgotPassword = "Quên mật khẩu?";
  static const cEmailOrUser = "Tên tài khoản hoặc email ";
  static const cDontHaveAnAccount = "Bạn chưa có tài khoản ? ";
  static const cAlreadyAnAccount = "Bạn đã có tài khoản ? ";
  static const cAuthenticating = "Đang xác thực.... ";

  static const cUsername = "Tên tài khoản";
  static const cPhoneNumber = "Số điện thoại";
  static const cUsernameRequire = "Tên tài khoản là bắt buộc";
  static const cPhoneNumberRequire = "Số điện thoại là bắt buộc";
  static const cEmailRequire = "Email là bắt buộc";
  static const cPasswordRequire = "Mật khẩu là bắt buộc";
  static const cConfirmPasswordRequire = "Xác nhận mật khẩu là bắt buộc";
  static const cCountrySelected = "Lựa chọn quốc gia";
  static const cEmail = "Email";
  static const cValidEmailMessage =
      "Vui lòng cung cấp một địa chỉ email hợp lệ";
  static const cRegistering = "Đang đăng ký tài khoản";
  static const cRegisterFailed = "Đang đăng ký tài khoản không thành công";
  static const cReEnterLoginForm = "Nhập lại dữ liệu tài khoản";
  static const cEnterUrlString = "Enter request URL";
  static const cUrlString = "Request URL";

  // class detail page
  static const cEnterClassCode = "Nhập mã lớp";
  static const cEnterClassName = "Nhập tên lớp";
  static const cEnterContactName = "Nhập tên người liên lạc";
  static const cEnterContactPhone = "Nhập sdt người liên lạc";
  static const cEnterNumberOfStudent = "Nhập sỹ số lớp";
  static const cClassName = "Tên lớp học";
  static const cClassCode = "Mã lớp học";
  static const cContactName = "Người liên lạc";
  static const cContactPhone = "Sdt liên lạc";
  static const cNumberOfStudent = "Sỹ số lớp";
  static const cStartDate = "Ngày bắt đầu";

  //student detail page
  static const cEnterStudentCode = "Nhập mã học sinh";
  static const cEnterStudentName = "Nhập tên học sinh";
  static const cEnterStudentAge = "Nhập tuổi học sinh";
  static const cEnterAddress = "Nhập địa chỉ học sinh";
  static const cEnterSchoolName = "Nhập tên trường học";
  static const cEnterParentName = "Nhập tên cha mẹ";
  static const cEnterParentPhone = "Nhập sdt cha mẹ";
  static const cEnterState = "Nhập sdt cha mẹ";
  static const cStudentName = "Tên học sinh";
  static const cStudentAge = "Tuổi học sinh";
  static const cStudentCode = "Mã học sinh";
  static const cSchoolName = "Tên trường học";
  static const cAddress = "Địa chỉ học sinh";
  static const cParentName = "Tên cha mẹ";
  static const cParentPhone = "Sdt cha mẹ";
  static const cState = "Trạng thái";

  // button
  static const cLoginButton = "Đăng nhập";
  static const cLoginWithFingerButton = "Đăng nhập bằng vân tay";
  static const cSignUpButton = "Đăng ký";
  static const cBackToLogin = "Quay lại trang đăng nhập";
  static const cCancelButton = "Huỷ bỏ";
  static const cSaveButton = "Lưu";
  static const cExportButton = "Xuất dữ liệu";
  static const cImportButton = "Cập nhật dữ liệu mới";

  // form common
  static const cDataInvalid = "Dữ liệu nhập ko chính xác";

  // Add data
  static const cSaveDataSuccess = "Lưu mới dữ liệu thành công!";
  static const cSaveDataSuccessMessage = "Thành công rồi vợ yêu ơi!";
  static const cSaveDataFail = "Lưu dữ liệu thất bại!";
  static const cSaveDataFailMessage = "Vợ yêu lưu dữ liệu lỗi rồi";
  static const cBackUpInitUrlString = "";
  static const cBackUpInitString =
      "Nhấn nút Cập nhật dữ liệu để load dữ liệu từ server.\n"
              "Nhấn nút Xuất dữ liệu để xuất dữ liệu ra thư mục của server.\n" +
          "Lưu ý: Khi nhấn cập nhật dữ liệu thì dữ liệu trong máy sẽ được làm mới.\n" +
          "Các bước thực hiện: \n\n" +
          "B1: Lấy địa chỉ ip ghi trên form server thay thế vào link request Url\n" +
          "VD: Ip trên server là: 10.1.3.136 thì đổi http://localhost thành http://10.1.3.136 \n\n"
          "B2: Nhấn nút xuất dữ liệu để backup ra dữ liệu sang server.\n" +
          "B3: Nhấn nút Cập nhật dữ liệu để làm mới dữ liệu trên app.\n";
}
