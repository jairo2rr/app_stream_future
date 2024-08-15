import 'package:app_stream_future/core/constants/asset_paths.dart';
import 'package:app_stream_future/core/exceptions/image_exception.dart';
import 'package:app_stream_future/core/utils/network_image_loader.dart';
import 'package:flutter/material.dart';

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

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<String>(
          future: widget.networkLoader.loadImage(widget.idImage ?? 0),
          builder: (_, AsyncSnapshot<String> snapshot) {
            if (widget.idImage == null || snapshot.connectionState == ConnectionState.waiting) {
              return Image.asset(AssetPaths.defaultImage);
            } else if (snapshot.hasError) {
              print("Has an error");
              if (errorMessage == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    errorMessage = (snapshot.error as CustomException).message;
                  });
                });
              }
              return Image.asset(AssetPaths.errorImage);
            } else if (snapshot.hasData) {
              if(errorMessage != null){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    errorMessage=null;
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
        Text(errorMessage ?? ""), // Mostrar el mensaje de error
      ],
    );
  }
}
