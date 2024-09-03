

import 'package:app_stream_future/core/constants/asset_paths.dart';
import 'package:flutter/material.dart';

abstract class ImageState{
  String getStateMessage();
  Widget render({String? pathImage});
}

class LoadingState implements ImageState{
  @override
  String getStateMessage() => "Loading...";

  @override
  Widget render({String? pathImage}) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)
      )
    );
  }

}

class LoadedState implements ImageState{
  @override
  String getStateMessage() => "Image loaded successfully!";

  @override
  Widget render({String? pathImage}) {
    return Image.asset(pathImage ?? AssetPaths.defaultImage);
  }


}

class ErrorState implements ImageState{
  final String errorMessage;

  ErrorState({required this.errorMessage});

  @override
  String getStateMessage() => "Error: $errorMessage";

  @override
  Widget render({String? pathImage}) {
    return Image.asset(AssetPaths.errorImage);
  }

}