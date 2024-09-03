
import 'package:app_stream_future/core/services/notification_service.dart';
import 'package:app_stream_future/core/services/sms_notification_service.dart';
import 'package:app_stream_future/domain/entities/contact.dart';

class SMSNotificationAdapter implements NotificationService{

  final SMSNotificationService smsNotificationService;

  SMSNotificationAdapter(this.smsNotificationService);

  @override
  void send(Contact receiver, String message) {
    smsNotificationService.sendSMS(phoneNumber: receiver.phoneNumber, message: message);
  }

}