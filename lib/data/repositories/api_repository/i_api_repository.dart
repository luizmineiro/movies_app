import '../../models/api_response_model.dart';

abstract interface class IApiRepository {
  Future<(String?, ApiResponseModel<T>?)> get<T>(String endPoint);
}