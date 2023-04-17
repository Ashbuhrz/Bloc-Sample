import 'package:flutter_bloc_login/api/models/api_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'models/user.dart';

part 'client.g.dart';

@RestApi(baseUrl: "https://kartypredev.westeurope.cloudapp.azure.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/sign-up")
  Future<ApiResponse> signUp(@Body() User user);
}
