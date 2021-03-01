import 'dart:convert';

import 'package:http/http.dart';

class HttpService {

//  Future<String> getPosts() async {
//    final String postsURL = 'http://localhost:9999/v1/user/login';
//    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{"username": "hanhnd6", "password": "123457"}';
//    Response res = await post(postsURL, headers: headers, body: json);
//
//    if (res.statusCode == 200) {
//      List<dynamic> body = jsonDecode(res.body);
//
//      List<String> posts = body
//          .map(
//            (dynamic item) => item.toString(),
//      )
//          .toList();
//
//      return posts[0];
//    } else {
//      throw "Can't get posts.";
//    }
//  }
  Future<String> getPosts() async{
    String body = '{"username": "hanhnd6", "password": "123457"}';
    Map<String, String> headers = {"Content-type": "application/json"};
    Response res = await post('http://localhost:9999/v1/user/login', headers: headers, body: body);
    return res.body;
  }

}