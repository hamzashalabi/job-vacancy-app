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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacant Jobs'),
      ),
      // future builder populated with the api data
      body: FutureBuilder<List<ApiJobVacancy>>(
        future: apiService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // reusable dialog -> more details in utilities folder
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showErrorDialog(
                context: context,
                content:
                    'Failed to work, please check your internet connection.',
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
      ),
    );
  }
}
