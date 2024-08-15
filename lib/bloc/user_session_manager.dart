
import 'dart:math';

class UserSessionManager {
  static UserSessionManager? _instance;
  String? _userToken;

  UserSessionManager._(){
    _instance = this;
  }

  factory UserSessionManager() => _instance ?? UserSessionManager._();

  void activateSession(){
    _userToken = _generateToken();
    print(_userToken);
  }

  String? get userToken => _userToken;

  bool validateToken(String userToken){
    return _userToken == userToken;
  }

  String _generateToken(){
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz/|,.><!@#%&';
    const int tokenLength = 16;
    final Random random = Random();

    return List.generate(tokenLength, (index)=>chars[random.nextInt(chars.length)]).join('');
  }

}