
class SMSNotificationService{
  void sendSMS({required String phoneNumber, required String message}){
    print('Sending SMS to $phoneNumber: $message');
  }
}