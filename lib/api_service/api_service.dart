import 'api_job_vacancy.dart';
import 'api_provider.dart';

class ApiService implements ApiProvider {
  final ApiProvider provider;

  const ApiService(this.provider);

  @override
  Future<List<ApiJobVacancy>> fetchData() => provider.fetchData();
}

// this class represents the interface of the logic in the api service 
// as all communications from the ui of the app goes through here 
// and no direct communiction with the logic happens without going through this logic interface 

// this also represents the MVVM patteren as in the following
// ApiJobVacancy represents the data model 
// ApiServiceProvider is the helper class 
// ApiService represents the view model 
// and the ui of the app is the view  