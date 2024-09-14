import 'package:flutter/material.dart';
import 'package:job_vacancy/views/job_view.dart';
import 'package:job_vacancy/views/vacancy_list_view.dart';

// removed the stateless widget class
// in order to help maintain the state of the app better
// this way the app only restarts if it is closed
void main() {
  runApp(MaterialApp(
    title: 'Job Matcher',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    routes: {
      VacancyListView.routeName: (context) => const VacancyListView(),
      JobView.routeName: (context) => const JobView(),
    },
    initialRoute: VacancyListView.routeName,
  ));
}
