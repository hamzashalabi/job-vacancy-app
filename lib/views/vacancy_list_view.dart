//import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:job_vacancy/api_service/api_job_vacancy.dart';
import 'package:job_vacancy/api_service/api_provider.dart';
import 'package:job_vacancy/api_service/api_service.dart';
import 'package:job_vacancy/api_service/api_service_provider.dart';
import 'package:job_vacancy/utilities/dialogs/error_dialog.dart';
import 'package:job_vacancy/utilities/dialogs/no_vacancies.dart';
import 'package:job_vacancy/widgets/card_view.dart';

class VacancyListView extends StatefulWidget {
  static String routeName = '/vacancy-list';
  const VacancyListView({super.key});

  @override
  State<VacancyListView> createState() => _VacancyListViewState();
}

class _VacancyListViewState extends State<VacancyListView> {
  // in the api service folder for more details
  final ApiProvider provider = ApiServiceProvider();
  late final ApiService apiService = ApiService(provider);

  late List<ConnectivityResult> _connectivityResult;
  late Stream<List<ConnectivityResult>> _connectivityStream;
  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _checkInitialConnection();
    _listenToConnectivityChanges();
  }

  // Check the initial state of the connection when the app starts
  Future<void> _checkInitialConnection() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = _connectivityResult != ConnectivityResult.none;
    });

    if (_isOnline) {
      apiService.fetchData();
    }
  }

  // Listen for changes in connection
  void _listenToConnectivityChanges() {
    _connectivityStream.listen((List<ConnectivityResult> result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });

      if (_isOnline) {
        apiService.fetchData(); // Recall the API when the user is back online
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacant Jobs'),
        elevation: 8,
      ),
      // future builder populated with the api data
      body: _isOnline
          ? FutureBuilder<List<ApiJobVacancy>>(
              future: apiService.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // reusable dialog -> more details in utilities folder
                  // text of error dialog is provided in exceptions classes in
                  // api service folder and passed to here by overriding
                  // the toString() method in those classes
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showErrorDialog(
                      context: context,
                      content: snapshot.error.toString(),
                    );
                  });
                  return const SizedBox();
                } else if (snapshot.hasData && snapshot.data != null) {
                  List<ApiJobVacancy> vacancies = snapshot.data!;

                  if (vacancies.isEmpty) {
                    // reusable dialog -> more details in utilities folder
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showNoVacanciesDialog(
                        context: context,
                        content: 'No vacancies available at the moment.',
                      );
                    });
                    return const SizedBox();
                  }
                  // used ListView builder for lazy loading and big amounts of data
                  return ListView.builder(
                    itemCount: vacancies.length,
                    itemBuilder: (context, index) {
                      return CardView(
                        vacancy: vacancies[index],
                      );
                    },
                  );
                } else {
                  // reusable dialog -> more details in utilities folder
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showErrorDialog(
                      context: context,
                      content: 'Failed to work, There is No Available Data',
                    );
                  });
                  return const SizedBox();
                }
              },
            )
          : const Center(child: Text('no internet connection')),
    );
  }
}
