import 'package:dio/dio.dart';
import 'package:smiley/Model/joke_model.dart';

import '../Database/db.dart';

class ApiCall{
  static final ApiCall _instance = ApiCall.internal();

  factory ApiCall() => _instance;

  ApiCall.internal();

  static final Dio _dio = Dio();

  static Future<JokeModel> getJokes(url)async{
    try {
      Response response = await _dio.get(url);
      return JokeModel.fromJson(response.data);

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return JokeModel.withError("Data not found / Connection issue");
    }
  }

}

class NetworkError extends Error {}