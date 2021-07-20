import 'package:flutter/material.dart';
import 'package:techno_vile_blog/models/message_model.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final List<MessageModel>? messages = [];

  @override
  void initState() {
    super.initState();
  }

  Widget buildMessage(MessageModel? messageModel) {
    return ListTile(
      title: Text('${messageModel!.title}'),
      subtitle: Text('${messageModel.body}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: messages!.map(buildMessage).toList(),
    );
  }
}
