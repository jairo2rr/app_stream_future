import 'package:app_stream_future/presentation/bloc/user_session_manager.dart';
import 'package:app_stream_future/presentation/controller/media_file_controller.dart';
import 'package:app_stream_future/domain/repositories/media_file_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MessagesTokenPage extends StatefulWidget {
  const MessagesTokenPage({super.key});

  @override
  State<MessagesTokenPage> createState() => _MessagesTokenPageState();
}

class _MessagesTokenPageState extends State<MessagesTokenPage> {
  final _paddingCard = const EdgeInsets.all(8.0);
  final TextEditingController _tokenTextController = TextEditingController();
  final UserSessionManager _userSessionManager = UserSessionManager();
  final MediaFileController mediaFileController = Get.find();
  MediaFileRepository? mediaFileRepository;


  bool? _isTokenValid;

  void _validateToken() {
    setState(() {
      _isTokenValid = _userSessionManager.validateToken(_tokenTextController.text);
    });

    _showSnackbar(_isTokenValid!);
  }

  void _showSnackbar(bool isTokenValid) {
    Get.snackbar(isTokenValid ? 'Success' : 'Error', isTokenValid ? 'Token validated successfully!' : 'Invalid token.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Token Validator"),
      ),
      body: Center(
        child: (_isTokenValid != null && _isTokenValid!) ? _userChatView() : _tokenInputCard(),
      ),
    );
  }

  Widget _userChatView(){
    return Column(
        children: [
          Expanded(
          flex: 2,
          // child: StreamBuilder(stream: mediaFileController.mediaFileManager.mediaFilesStream, builder: (_,AsyncSnapshot<Map<int,MediaFile>> snapshot){
          //   print(snapshot.data ?? "No data");
          //   if(snapshot.hasData && snapshot.data!.isNotEmpty){
          //     final mediaFiles = snapshot.data!.values.toList();
          //     return ListView.builder(
          //       itemCount: mediaFiles.length,
          //         itemBuilder: (_,index){
          //         return GestureDetector(
          //           onTap: (){
          //             mediaFiles[index].onClick();
          //           },
          //           child: mediaFiles[index].display(),
          //         );
          //         });
          //   }else{
          //     return const Center(child: Text("No media files."));
          //   }
          //   return SizedBox();
          // })
            child: Obx((){
              return ListView.builder(
                  itemCount: mediaFileController.mediaFiles.length,
                  itemBuilder: (_,index){
                    final mediaFiles = mediaFileController.mediaFiles.values.toList();
                    return GestureDetector(
                      onTap: (){
                        mediaFiles[index].onClick();
                      },
                      child: mediaFiles[index].display(),
                    );
                  });
            }),
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _mediaButtonChat(text: "Send message",onClick:(){
                mediaFileRepository = DecoratedMessageRepository();
                mediaFileController.sendNewMediaFile(mediaFileRepository!.createMediaFile());
              }),
              _mediaButtonChat(text: "Send giff",onClick:(){
                mediaFileRepository = GifRepository();
                mediaFileController.sendNewMediaFile(mediaFileRepository!.createMediaFile());
              }),
              _mediaButtonChat(text: "Send photo",onClick:(){
                mediaFileRepository = ImageRepository();
                mediaFileController.sendNewMediaFile(mediaFileRepository!.createMediaFile());
              }),
            ],
          )
        ],
    );
  }

  Widget _tokenInputCard() {
    return Card(
      child: Padding(
        padding: _paddingCard,
        child: Row(
          children: [
            Expanded(
              child: _tokenTextField(),
            ),
            _validateButton(),
          ],
        ),
      ),
    );
  }

  Widget _tokenTextField() {
    return TextField(
      controller: _tokenTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter a token...",
      ),
    );
  }

  Widget _validateButton() {
    return IconButton(
      onPressed: _validateToken,
      icon: const Icon(Icons.send),
    );
  }

  Widget _mediaButtonChat({required String text, required Function onClick}) {
    return OutlinedButton(onPressed: ()=>onClick(), child: Text(text));
  }
}
