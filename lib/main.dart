import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login/api/client.dart';
import 'package:flutter_bloc_login/bloc/login/signup_bloc.dart';
import 'package:flutter_bloc_login/ui/login_screen.dart';

void main() {
  final dio = Dio();
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  final apiClient = RestClient(dio);

  runApp(MyApp(apiClient: apiClient));
}

class MyApp extends StatelessWidget {
  final RestClient apiClient;

  MyApp({required this.apiClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Signup',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => SignupBloc(apiClient: apiClient),
        child: const SignupScreen(),
      ),
    );
  }
}
