// ignore_for_file: library_private_types_in_public_api

import 'package:chatbot/chat_message.dart';
import 'package:chatbot/messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {  @override
  void initState() {
    super.initState();
    _messages.add(const ChatMessage(
      text: '👋 Welcome! How can I assist you today?',
      isUser: false,
    ));
  }
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));

      String botResponse = getBotResponse(text.toLowerCase());
      _messages.add(ChatMessage(
        text: botResponse,
        isUser: false,
      ));
    });
  }

  String getBotResponse(String userMessage) {
    if (keywords.contains(userMessage.toLowerCase())) {
      return responses.elementAt(keywords.indexOf(userMessage));
    } else {
      return "Sorry, I didn't understand your response.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
