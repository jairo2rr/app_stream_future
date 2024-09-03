import 'dart:ffi';

import 'package:app_stream_future/presentation/bloc/media_file_manager.dart';
import 'package:app_stream_future/core/adapters/email_notification_adapter.dart';
import 'package:app_stream_future/core/adapters/sms_notification_adapter.dart';
import 'package:app_stream_future/core/services/email_notification_service.dart';
import 'package:app_stream_future/core/services/notification_service.dart';
import 'package:app_stream_future/core/services/sms_notification_service.dart';
import 'package:app_stream_future/domain/entities/contact.dart';
import 'package:app_stream_future/domain/entities/media_file.dart';
import 'package:get/get.dart';

class MediaFileController extends GetxController {
  final mediaFileManager = MediaFileManager();
  final NotificationService emailNotificationAdapter =
      EmailNotificationAdapter(EmailNotificationService());
  final NotificationService smsNotificationAdapter =
      SMSNotificationAdapter(SMSNotificationService());
  var messageCount = 0.obs;
  var mediaFiles = <int, MediaFile>{}.obs;

  final Contact principalContact = Contact(
      fullName: "Jairo Aldair",
      username: "jairo.2rr",
      phoneNumber: "+51936759308",
      email: "jairo.2aldair@gmail.com");

  @override
  void onInit() {
    super.onInit();
    mediaFileManager.mediaFileCounter.listen((counter) {
      messageCount.value = counter;
    });
    mediaFileManager.mediaFilesStream.listen((mediaList) {
      mediaFiles.value = mediaList;
    });
  }

  void sendNewMediaFile(MediaFile mediaFile) {
    mediaFileManager.updateMediaFileList(
        time: DateTime.now().millisecondsSinceEpoch, mediaFile: mediaFile);
    _sendNotifications(mediaFile);
  }

  @override
  void onClose() {
    mediaFileManager.dispose();
    super.onClose();
  }

  void _sendNotifications(MediaFile mediaFile) {
    if (mediaFile is DecoratedMessage) {
      emailNotificationAdapter.send(principalContact, mediaFile.message);
      smsNotificationAdapter.send(principalContact, mediaFile.message);
    } else if (mediaFile is ImageFile) {
      emailNotificationAdapter.send(principalContact, "Sent an image 📷");
      smsNotificationAdapter.send(principalContact, "Sent an image 📷");
    } else if (mediaFile is GifFile) {
      emailNotificationAdapter.send(principalContact, "Sent a GIF 🎞️");
      smsNotificationAdapter.send(principalContact, "Sent an GIF 🎞️");
    } else {
      print("Unknown media file type");
    }
  }
}
