import 'package:app_stream_future/core/exceptions/image_exception.dart';
import 'package:app_stream_future/domain/entities/custom_image.dart';
import 'package:flutter/material.dart';

abstract class ImageLoader{
  Future<String> loadImage(String pathImage);
}


class NetworkImageLoader implements ImageLoader{

  @override
  Future<String> loadImage(String pathImage) async{
    String imageUrl = 'https://picsum.photos/200/300?random=$pathImage';
    try{
      await Future.delayed(const Duration(seconds: 2));
      if(int.parse(pathImage) %2 == 0){
        throw NotFoundImageException(message: "Image not found. Please try again.");
      }
      if(int.parse(pathImage) %5 == 0){
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
  Future<String> loadImage(String pathImage) {
    // TODO: implement loadImage
    throw UnimplementedError();
  }

}

class FirebaseImageLoader implements ImageLoader{
  @override
  Future<String> loadImage(String pathImage) {
    // TODO: implement loadImage
    throw UnimplementedError();
  }

}