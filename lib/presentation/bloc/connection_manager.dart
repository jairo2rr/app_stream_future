
import 'dart:async';

class ConnectionManager {
  final StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  updateConnectionStatus(bool isConnected){
    _connectionStatusController.sink.add(isConnected);
  }

  dispose(){
    _connectionStatusController.close();
  }
}