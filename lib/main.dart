import 'dart:math';

import 'package:app_stream_future/bloc/connection_manager.dart';
import 'package:app_stream_future/bloc/message_manager.dart';
import 'package:app_stream_future/bloc/user_session_manager.dart';
import 'package:app_stream_future/core/navigation/app_pages.dart';
import 'package:app_stream_future/core/navigation/app_routes.dart';
import 'package:app_stream_future/core/utils/network_image_loader.dart';
import 'package:app_stream_future/presentation/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'presentation/image_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stream and Future App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConnectionManager connectionManager = ConnectionManager();
  MessageManager messageManager = MessageManager();
  ImageLoader networkLoader = NetworkImageLoader();
  UserSessionManager userSessionManager = UserSessionManager();

  final _messageTextController = TextEditingController();
  final _paddingCard = const EdgeInsets.all(8.0);
  int? idImageRandom;
  String? messageDisplayed;

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
                const Icon(Icons.person),
                const Text("Jairo"),
                const SizedBox(
                  width: 4.0,
                ),
                StreamBuilder(
                  stream: connectionManager.connectionStatus,
                  builder: (_, AsyncSnapshot<bool> snapshot) {
                    return CircleAvatar(
                      backgroundColor:
                          (snapshot.data ?? false) ? Colors.green : Colors.red,
                      radius: 5.0,
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                                      if(newValue) userSessionManager.activateSession();
                                    });
                              }),
                          Row(children: [
                            const Text("Copy token"),
                            IconButton(onPressed: (){
                              var userToken = userSessionManager.userToken;
                              if(userToken != null){
                                Clipboard.setData(ClipboardData(text: userToken));
                                print("Token copied to clipboard.");
                              }else{
                                print("Token not found. User is not connected.");
                              }
                            }, icon: const Icon(Icons.copy))
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
                              controller: _messageTextController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter a message..."),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                String message =
                                    _messageTextController.text.trim();
                                if (message.isNotEmpty) {
                                  messageManager.updateMessageList(
                                      time:
                                          DateTime.now().millisecondsSinceEpoch,
                                      message: _messageTextController.text);
                                  _messageTextController.clear();
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
                              idImage: idImageRandom,
                              networkLoader: networkLoader,
                              onGetMessage: (messageFromImage){
                                setState(() {
                                  messageDisplayed = messageFromImage;
                                });
                              },
                          ),
                          Text(messageDisplayed ?? ""),
                          FilledButton(
                              onPressed: () {
                                setState(() {
                                  idImageRandom = Random().nextInt(10);
                                });
                              },
                              child: const Text("Get"))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("You"),
                              const SizedBox(width: 8.0),
                              StreamBuilder(
                                  stream: connectionManager.connectionStatus,
                                  builder: (_, AsyncSnapshot<bool> snapshot) {
                                    bool isOnline = snapshot.data ?? false;
                                    return Text(
                                      (isOnline) ? "Online" : "Offline",
                                      style: TextStyle(
                                          color: (isOnline)
                                              ? Colors.green
                                              : Colors.grey),
                                    );
                                  }),
                            ],
                          ),
                          const Divider(),
                          contactItem("Friend 1"),
                          const Divider(),
                          contactItem("Friend 2"),
                          const Divider(),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.MESSAGES);
                          },
                          child: Row(
                            children: [
                              const Text("Messages",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8.0),
                              StreamBuilder(
                                  stream: messageManager.messageCounter,
                                  builder: (_, AsyncSnapshot<int> snapshot) {
                                    return CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Text("${snapshot.data ?? 0}"));
                                  })
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
