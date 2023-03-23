import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<List<Posts>?> getPost() async {
    String api = "https://jsonplaceholder.typicode.com/photos";
    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      List<dynamic> allData = jsonDecode(res.body);

      List<Posts> allPost = allData
          .map(
            (e) => Posts.fromMap(data: e),
          )
          .toList();
      return allPost;
    }
    return null;
  }
}
