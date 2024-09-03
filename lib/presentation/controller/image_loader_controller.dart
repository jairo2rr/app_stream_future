import 'dart:async';

import 'package:app_stream_future/domain/entities/custom_image.dart';
import 'package:app_stream_future/domain/entities/image_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageLoaderController extends GetxController {
  final customImage = CustomImage(pathImage: "19");
  final StreamController<bool> _isUpdatedStateController = StreamController<bool>();
  Stream<bool> get isUpdateState => _isUpdatedStateController.stream;

  @override
  void onInit() {
    super.onInit();
    _testChangeState();
  }

  void changeState() {
    customImage.changeState(state: LoadedState());
    _isUpdatedStateController.add(true);
  }

  Future<void> _testChangeState() async{
    try{
      await Future.delayed(const Duration(seconds: 4));
      changeState();
    }catch(e){
      rethrow;
    }
  }

  Future<void> loadImageFromLoader() async {
    await customImage.imageLoader.loadImage(customImage.pathImage).then((response){
      print(response);
      customImage.pathImage = response;
      customImage.changeState(state: LoadedState());
      _isUpdatedStateController.add(true);
    }).catchError((error){
      print(error);
      customImage.changeState(state: ErrorState(errorMessage: error));
      _isUpdatedStateController.add(true);
    });
  }
}
