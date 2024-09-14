import 'package:dio/dio.dart';
import 'package:job_vacancy/api_service/consts.dart';
import 'api_exceptions.dart';
import 'api_job_vacancy.dart';
import 'api_provider.dart';

// the class that implements our interface
class ApiServiceProvider implements ApiProvider {
  // using dio package for api management instead of the http package
  // because the error handling in dio is more advanced then http
  //
  // it takes 10 secs for each before unleashing an error
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  @override
  Future<List<ApiJobVacancy>> fetchData() async {
    try {
      // api url in consts in api service
      Response response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data as List<dynamic>;
        // converting the json data into an ApiJobVacancy object
        List<ApiJobVacancy> vacancies =
            jsonData.map((json) => ApiJobVacancy.fromJson(json)).toList();
        return vacancies;
      } else {
        // in exceptions file
        throw ResponseExcpetion();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        // in exceptions file
        throw DioConnectionTimeOutException();
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // in exceptions file
        throw DioReceiveTimeOutException();
      } else {
        // in exceptions file
        throw GenericException();
      }
    }
  }
}
