import 'package:app_stream_future/domain/entities/contact.dart';

abstract class NotificationService{
  void send(Contact receiver, String message);
}