import 'package:flutter/material.dart';
import 'package:job_vacancy/api_service/api_job_vacancy.dart';
import 'package:job_vacancy/views/job_view.dart';

class CardView extends StatelessWidget {
  final ApiJobVacancy vacancy;

  const CardView({
    super.key,
    required this.vacancy,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // the context holds the data with him when navigating to the other screen
          // go to extensions for more details
          Navigator.of(context).pushNamed(
            JobView.routeName,
            arguments: vacancy,
          );
        },
        child: Container(
          width: size.width * 0.8,
          height: 250,
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vacancy.jobTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vacancy.company,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 250,
                        maxHeight: 150,
                      ),
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        vacancy.description,
                        style: const TextStyle(fontSize: 14),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Posted: ${vacancy.postingDate}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    vacancy.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
