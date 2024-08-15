import 'package:app_stream_future/core/exceptions/image_exception.dart';

abstract class ImageLoader{
  Future<String> loadImage(int code);
}


class NetworkImageLoader implements ImageLoader{

  @override
  Future<String> loadImage(int code) async{
    String imageUrl = 'https://picsum.photos/200/300?random=$code';
    try{
      await Future.delayed(const Duration(seconds: 2));
      if(code %2 == 0){
        throw NotFoundImageException(message: "Image not found. Please try again.");
      }
      if(code %5 == 0){
        throw HttpException(message: "Something is wrong.");
      }
      return imageUrl;
    }catch(e){
      rethrow;
    }
  }
}

class CachedImageLoader implements ImageLoader{
  @override
  Future<String> loadImage(int code) {
    // TODO: implement loadImage
    throw UnimplementedError();
  }

}

class FirebaseImageLoader implements ImageLoader{
  @override
  Future<String> loadImage(int code) {
    // TODO: implement loadImage
    throw UnimplementedError();
  }

}