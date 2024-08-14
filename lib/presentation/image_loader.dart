import 'package:app_stream_future/core/constants/asset_paths.dart';
import 'package:app_stream_future/core/utils/network_image_loader.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final int? idImage;
  final NetworkImageLoader networkLoader;

  const ImageLoader(
      {super.key, required this.idImage, required this.networkLoader});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: networkLoader.fetchImageUrl(idImage ?? 0),
        builder: (_, AsyncSnapshot<String> snapshot) {
          if(idImage == null){
            return Image.asset(AssetPaths.defaultImage);
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Image.asset(AssetPaths.defaultImage);
          }else if(snapshot.hasError){
            return Image.asset(AssetPaths.errorImage);
          }else if(snapshot.hasData){
            return Image.network(
              snapshot.data!,
              errorBuilder: (_,error,__){
                print(error.toString());
                return Image.asset(AssetPaths.errorImage);
                },
            );
          }else{
            return Image.asset(AssetPaths.errorImage);
          }
        });
  }
}
