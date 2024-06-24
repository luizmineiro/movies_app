import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/core/const/erros_const.dart';
import 'package:movies_app/core/services/dot_env_service.dart';

import '../../../models/api_response_model.dart';
import '../i_api_repository.dart';

class DioRepositoryImpl implements IApiRepository {
  final Dio _dio;

  DioRepositoryImpl(this._dio);
  @override
  Future<(String?, ApiResponseModel<T>?)> get<T>(String endPoint) async {
    try {
      final response = await _dio.get(
        endPoint,
        options: Options(
          headers: {
            "Authorization": "Bearer ${DotEnvService.getApiToken}",
          },
        ),
      );
      return (
        null,
        ApiResponseModel<T>(
            data: response.data as T, statusMessage: response.statusMessage)
      );
    } on DioException catch (dioException) {
      final errorMessage = dioException.message ?? ErrosConst.API_DEFAULT_ERROR;
      log(errorMessage);
      return (errorMessage, null);
    }
  }
}
