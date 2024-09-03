import 'package:app_stream_future/core/constants/asset_paths.dart';
import 'package:app_stream_future/core/exceptions/image_exception.dart';
import 'package:app_stream_future/core/utils/image_loader.dart';
import 'package:app_stream_future/presentation/controller/image_loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageContent extends StatefulWidget {
  final int? idImage;
  final ImageLoader networkLoader;
  final Function(String? message) onGetMessage;

  const ImageContent(
      {super.key, required this.idImage, required this.networkLoader, required this.onGetMessage});

  @override
  State<ImageContent> createState() => _ImageContentState();
}

class _ImageContentState extends State<ImageContent> {
  ImageLoaderController imageController = Get.find();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<String>(
          future: widget.networkLoader.loadImage(widget.idImage?.toString() ?? "0"),
          builder: (_, AsyncSnapshot<String> snapshot) {
            if (widget.idImage == null || snapshot.connectionState == ConnectionState.waiting) {
              return Image.asset(AssetPaths.defaultImage);
            } else if (snapshot.hasError) {
              print("Has an error");
              if (_errorMessage == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _errorMessage = (snapshot.error as CustomException).message;
                  });
                });
              }
              return Image.asset(AssetPaths.errorImage);
            } else if (snapshot.hasData) {
              if(_errorMessage != null){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _errorMessage=null;
                  });
                });
              }
              return Image.network(
                snapshot.data!,
                errorBuilder: (_, error, __) {
                  return Image.asset(AssetPaths.errorImage);
                },
              );
            } else {
              return Image.asset(AssetPaths.errorImage);
            }
          },
        ),
        Text(_errorMessage ?? ""),
      ],
    );
  }
}
