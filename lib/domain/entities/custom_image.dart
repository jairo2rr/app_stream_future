
import 'package:app_stream_future/core/utils/image_loader.dart';
import 'package:app_stream_future/domain/entities/image_state.dart';
import 'package:flutter/material.dart';

class CustomImage{
  late ImageState state;
  String pathImage;
  late ImageLoader imageLoader;

  CustomImage({required this.pathImage, ImageLoader? imageLoader}){
    this.imageLoader = imageLoader ?? NetworkImageLoader();
    state = LoadingState();
  }

  String get messageState => state.getStateMessage();

  Widget render() => state.render();


  void changeState({required ImageState state}){
    this.state = state;
  }
}