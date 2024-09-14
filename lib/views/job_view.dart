import 'package:flutter/material.dart';
import 'package:job_vacancy/api_service/api_job_vacancy.dart';
import 'package:job_vacancy/extensions/get_arguments.dart';

class JobView extends StatefulWidget {
  static String routeName = '/job-view';
  const JobView({super.key});

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  @override
  Widget build(BuildContext context) {
    // this job value is taken from the context used to navigate to here
    // for more details check extensions
    final job = context.getArgument<ApiJobVacancy>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    job!.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.jobTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          job.company,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          job.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Icon(Icons.work),
                          title: Text('Job ID: ${job.jobID}'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text('Salary: ${job.salary}'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text('Location: ${job.location}'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.date_range),
                          title: Text('Posted: ${job.postingDate}'),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          job.longDescription,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
