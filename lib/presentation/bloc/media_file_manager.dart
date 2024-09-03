
import 'dart:async';

import 'package:app_stream_future/domain/entities/media_file.dart';

class MediaFileManager {

  final Map<int,MediaFile> _mediaFiles = {};

  final StreamController<Map<int,MediaFile>> _mediaFileController = StreamController<Map<int,MediaFile>>.broadcast();
  Stream<Map<int,MediaFile>> get mediaFilesStream => _mediaFileController.stream;

  final StreamController<int> _mediaFileCounter= StreamController<int>();
  Stream<int> get mediaFileCounter => _mediaFileCounter.stream;

  MediaFileManager(){
    mediaFilesStream.listen((messageList) => _mediaFileCounter.add(messageList.length));
  }

  updateMediaFileList({required int time,required MediaFile mediaFile}){
    _mediaFiles[time] = mediaFile;
    print('Added MediaFile: $mediaFile at time: $time');
    _mediaFileController.sink.add(Map.from(_mediaFiles));
    print('Updated Stream with ${_mediaFiles.length} items.');
  }

  dispose(){
    _mediaFileCounter.close();
    _mediaFileController.close();
  }

}
