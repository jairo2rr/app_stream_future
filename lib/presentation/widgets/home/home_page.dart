import 'dart:math';

import 'package:app_stream_future/domain/entities/image_state.dart';
import 'package:app_stream_future/presentation/bloc/connection_manager.dart';
import 'package:app_stream_future/presentation/bloc/media_file_manager.dart';
import 'package:app_stream_future/presentation/bloc/user_session_manager.dart';
import 'package:app_stream_future/presentation/controller/image_loader_controller.dart';
import 'package:app_stream_future/presentation/controller/media_file_controller.dart';
import 'package:app_stream_future/core/navigation/app_routes.dart';
import 'package:app_stream_future/core/utils/image_loader.dart';
import 'package:app_stream_future/domain/entities/media_file.dart';
import 'package:app_stream_future/presentation/widgets/home/image_loader.dart';
import 'package:app_stream_future/presentation/widgets/home/message_icon_with_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConnectionManager connectionManager = ConnectionManager();
  MediaFileManager mediaFileManager = MediaFileManager();
  ImageLoader networkLoader = NetworkImageLoader();
  UserSessionManager userSessionManager = UserSessionManager();
  final MediaFileController _messageController = Get.put(MediaFileController());
  final ImageLoaderController _testController = Get.put(ImageLoaderController());

  final _messageTextEditingController = TextEditingController();
  final _paddingCard = const EdgeInsets.all(8.0);
  int? _idImageRandom;
  String? _messageDisplayed;
  ImageState? imageTest;

  @override
  void initState() {
    //imageTest = _testController.customImage.value;
    super.initState();
    _testController.loadImageFromLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.person, size: 30),
                StreamBuilder(
                  stream: connectionManager.connectionStatus,
                  builder: (_, AsyncSnapshot<bool> snapshot) {
                    return CircleAvatar(
                      backgroundColor:
                          (snapshot.data ?? false) ? Colors.green : Colors.red,
                      radius: 5.0,
                    );
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.MESSAGES);
                    },
                    child: MessageIconWithBadge()
                  )
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Card(
                  child: Container(
                    padding: _paddingCard,
                    child: Column(
                      children: [
                        const Text("Connection"),
                        StreamBuilder(
                            stream: connectionManager.connectionStatus,
                            builder: (_, AsyncSnapshot<bool> snapshot) {
                              bool isConnected = snapshot.data ?? false;
                              return Switch(
                                  value: isConnected,
                                  onChanged: (newValue) {
                                    connectionManager
                                        .updateConnectionStatus(newValue);
                                    if (newValue)
                                      userSessionManager.activateSession();
                                  });
                            }),
                        Row(children: [
                          const Text("Copy token"),
                          IconButton(
                              onPressed: () {
                                var userToken = userSessionManager.userToken;
                                if (userToken != null) {
                                  Clipboard.setData(
                                      ClipboardData(text: userToken));
                                  print("Token copied to clipboard.");
                                } else {
                                  print(
                                      "Token not found. User is not connected.");
                                }
                              },
                              icon: const Icon(Icons.copy))
                        ])
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  child: Container(
                    padding: _paddingCard,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageTextEditingController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter a message..."),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              String message =
                              _messageTextEditingController.text.trim();
                              MediaFile messageFile = DecoratedMessage(message: message);
                              if (message.isNotEmpty) {
                                _messageController.sendNewMediaFile(messageFile);
                                _messageTextEditingController.clear();
                              }
                            },
                            icon: const Icon(Icons.send))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: _paddingCard,
                    child: Column(
                      children: [
                        const Text("Load an image!"),
                        ImageContent(
                          idImage: _idImageRandom,
                          networkLoader: networkLoader,
                          onGetMessage: (messageFromImage) {
                            setState(() {
                              _messageDisplayed = messageFromImage;
                            });
                          },
                        ),
                        Text(_messageDisplayed ?? ""),
                        FilledButton(
                            onPressed: () {
                              setState(() {
                                _idImageRandom = Random().nextInt(10);
                              });
                            },
                            child: const Text("Get"))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: StreamBuilder(stream: _testController.isUpdateState, builder: (_,__){
                    return _testController.customImage.render();
                  }),
                )
              ],
            ),
          ),
          // Expanded(
              //   child: Container(
              //     color: Colors.grey[300],
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
              //     child: Column(
              //       children: [
              //         Expanded(
              //           flex: 2,
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   const Text("You"),
              //                   const SizedBox(width: 8.0),
              //                   StreamBuilder(
              //                       stream: connectionManager.connectionStatus,
              //                       builder: (_, AsyncSnapshot<bool> snapshot) {
              //                         bool isOnline = snapshot.data ?? false;
              //                         return Text(
              //                           (isOnline) ? "Online" : "Offline",
              //                           style: TextStyle(
              //                               color: (isOnline)
              //                                   ? Colors.green
              //                                   : Colors.grey),
              //                         );
              //                       }),
              //                 ],
              //               ),
              //               const Divider(),
              //               contactItem("Friend 1"),
              //               const Divider(),
              //               contactItem("Friend 2"),
              //               const Divider(),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
        ),
      ),
    );
  }
}
