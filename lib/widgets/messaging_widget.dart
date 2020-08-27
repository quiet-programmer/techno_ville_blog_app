import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:techno_vile_blog/models/message_model.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage $message");
        final notification = message['notification'];
        setState(() {
          messages.add(
            MessageModel(
              title: notification['title'],
              body: notification['body'],
            ),
          );
        });
      },
      onBackgroundMessage: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage $message");
        final notification = message['data'];
        setState(() {
          messages.add(MessageModel(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onMessage $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  Widget buildMessage(MessageModel messageModel) {
    return ListTile(
      title: Text(messageModel.title),
      subtitle: Text(messageModel.body),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: messages.map(buildMessage).toList(),
    );
  }
}
