import 'api_job_vacancy.dart';

// an interface for our api methods
abstract class ApiProvider {
  Future<List<ApiJobVacancy>> fetchData();
}
