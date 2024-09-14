import 'package:flutter/material.dart';

// a data class that represents the data retrieved from the api
@immutable
class ApiJobVacancy {
  final String jobID;
  final String jobTitle;
  final String company;
  final String location;
  final String description;
  final String longDescription;
  final String salary;
  final String postingDate;
  final String imageUrl;

  const ApiJobVacancy({
    required this.jobID,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.description,
    required this.longDescription,
    required this.salary,
    required this.postingDate,
    required this.imageUrl,
  });

  // a constructor method that converts the json format data into an object
  factory ApiJobVacancy.fromJson(Map<String, dynamic> json) {
    return ApiJobVacancy(
      jobID: json['job_id'],
      jobTitle: json['title'],
      company: json['company'],
      location: json['location'],
      description: json['description'],
      longDescription: json['long_description'],
      salary: json['salary'],
      postingDate: json['date_posted'],
      imageUrl: json['image_url'],
    );
  }
}
