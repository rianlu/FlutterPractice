import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(FriendlyChatApp());
}

String _name = "W ZL";

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FriendlyChat',
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme,
        home: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(
          children: [
            _buildMessageList(),
            Divider(
              height: 1.0,
            ),
            _buildTextComposer()
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
        ? BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]))
        ) : null,
      ),
    );
  }

  /**
   * 释放资源
   */
  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  // 发送消息组件
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                    // log('State: $_isComposing');
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            _buildSendButton()
          ],
        ),
      ),
    );
  }

  // 发送按钮
  Widget _buildSendButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Theme.of(context).platform == TargetPlatform.iOS
          ? CupertinoButton(
              child: Text('Send'),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textController.text)
                  : null)
          : IconButton(
              icon: Icon(Icons.send),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textController.text)
                  : null),
    );
  }

// 消息列表
  Widget _buildMessageList() {
    return Flexible(
        child: ListView.builder(
      padding: EdgeInsets.all(0.0),
      reverse: true,
      itemBuilder: (_, int index) => _messages[index],
      itemCount: _messages.length,
    ));
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
          duration: const Duration(milliseconds: 00), vsync: this),
    );
    setState(() {
      _messages.add(message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(_name[0]),
              ),
            ),
            // 防止长文本超出屏幕
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(text),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

// 自定义主题
// IOS
final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

// Android
final ThemeData kDefaultTheme = ThemeData(
    primarySwatch: Colors.purple, accentColor: Colors.orangeAccent[400]);
