
import 'package:app_stream_future/core/navigation/app_routes.dart';
import 'package:app_stream_future/presentation/home/home_page.dart';
import 'package:app_stream_future/presentation/messages/message_by_token.dart';
import 'package:get/get.dart';

class AppPages{
  static final routes = [
    GetPage(name: AppRoutes.HOME, page: ()=> MyHomePage(title: 'Stream - Future App')),
    GetPage(name: AppRoutes.MESSAGES, page: ()=>MessagesTokenPage())
  ];
}