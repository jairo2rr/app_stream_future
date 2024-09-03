
import 'package:app_stream_future/core/constants/asset_paths.dart';
import 'package:flutter/material.dart';

abstract class MediaFile{
  void onClick();
  Widget display();
}

class ImageFile extends MediaFile{
  @override
  Widget display() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(AssetPaths.defaultImage, width: 100, height: 100,)
          ]
      ),
    );
  }

  @override
  void onClick() {
    print("Image clicked!");
  }

}

class DecoratedMessage extends MediaFile{
  String message;

  DecoratedMessage({this.message = "Decorated message"});

  @override
  Widget display() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(6)
          ),
          child: Text(message),
        ),]
      ),
    );
  }

  @override
  void onClick() {
    print("Decorated message clicked!");
  }

}

class GifFile extends MediaFile{
  @override
  Widget display() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
        Image.asset(AssetPaths.defaultGif, width: 100, height: 100,)
          ]
      ),
    );
  }

  @override
  void onClick() {
    print("Gif clicked!");
  }

}