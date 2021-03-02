class Global{
  static String Token = "";
}
class ResponseObj{
  bool status;
  dynamic data;
  String message;
  ResponseObj({
    this.status,
    this.data,
    this.message,
  });
  factory ResponseObj.fromJson(Map<String, dynamic> responseData){
    return ResponseObj(
        status: responseData['status'],
        data: responseData['data'],
        message: responseData['message'],
    );
  }
}