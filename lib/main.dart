import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/containers/cards.dart';
import 'package:news_app/services/NewsService.dart';
import 'package:news_app/views/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<void>(
        future: NewsService(Dio()).getNews("general"),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return loading indicator while waiting for data
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error case
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            // Once data is fetched, navigate to HomeView
            return HomeView();
          }
        },
      ),
    );
  }
}
