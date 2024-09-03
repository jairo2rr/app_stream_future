import 'package:app_stream_future/domain/entities/media_file.dart';

abstract class MediaFileRepository{
  MediaFile createMediaFile();
}

class ImageRepository implements MediaFileRepository{
  @override
  MediaFile createMediaFile() {
    return ImageFile();
  }

}

class DecoratedMessageRepository implements MediaFileRepository{
  @override
  MediaFile createMediaFile() {
    return DecoratedMessage();
  }

}

class GifRepository implements MediaFileRepository{
  @override
  MediaFile createMediaFile() {
    return GifFile();
  }

}