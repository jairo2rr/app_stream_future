import 'package:app_stream_future/bloc/user_session_manager.dart';
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
        child: _tokenInputCard(),
      ),
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
}
