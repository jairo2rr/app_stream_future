
import 'dart:async';

class MessageManager {

  final Map<int,String> _messages = {};

  final StreamController<Map<int,String>> _messageController = StreamController<Map<int,String>>();
  Stream<Map<int,String>> get messagesStream => _messageController.stream;

  final StreamController<int> _messageCounter= StreamController<int>();
  Stream<int> get messageCounter => _messageCounter.stream;

  MessageManager(){
    messagesStream.listen((messageList) => _messageCounter.add(messageList.length));
  }

  updateMessageList({required int time,required String message}){
    _messages[time] = message;
    _messageController.add(Map.from(_messages));
  }

  dispose(){
    _messageCounter.close();
    _messageController.close();
  }

}
