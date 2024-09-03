
class EmailNotificationService{
  void sendEmail({required String contact, required String subject, required String body}){
    print('Sending email to $contact with subject `$subject`: $body');
  }
}

