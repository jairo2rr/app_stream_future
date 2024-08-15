
abstract class CustomException implements Exception{
  String? message;
  CustomException({this.message});
}

class NotFoundImageException extends CustomException{
  NotFoundImageException({super.message});
}

class HttpException extends CustomException{
  HttpException({super.message});
}