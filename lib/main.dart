import 'dart:math';

import 'package:app_stream_future/bloc/connection_manager.dart';
import 'package:app_stream_future/bloc/message_manager.dart';
import 'package:app_stream_future/bloc/user_session_manager.dart';
import 'package:app_stream_future/core/navigation/app_pages.dart';
import 'package:app_stream_future/core/navigation/app_routes.dart';
import 'package:app_stream_future/core/utils/network_image_loader.dart';
import 'package:app_stream_future/presentation/home/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'presentation/home/image_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stream and Future App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.routes,
    );
  }
}
