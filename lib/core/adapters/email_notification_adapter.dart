
import 'package:app_stream_future/core/services/email_notification_service.dart';
import 'package:app_stream_future/core/services/notification_service.dart';
import 'package:app_stream_future/domain/entities/contact.dart';

class EmailNotificationAdapter implements NotificationService{

  final EmailNotificationService emailService;

  EmailNotificationAdapter(this.emailService);

  @override
  void send(Contact receiver, String message) {
    emailService.sendEmail(contact: receiver.email, subject: 'Notification',body: message);
  }
}