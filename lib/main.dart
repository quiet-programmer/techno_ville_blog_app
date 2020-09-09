import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:techno_vile_blog/services/database.dart';
import 'package:techno_vile_blog/src/app.dart';
import 'package:workmanager/workmanager.dart';

//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";

// flutter local notification setup
void showNotification(v, flp) async {
  var android = AndroidNotificationDetails(
    'channel id',
    'channel NAME',
    'CHANNEL DESCRIPTION',
    priority: Priority.High,
    importance: Importance.Max,
  );
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await flp.show(
    0,
    'Virtual intelligent solution',
    '$v',
    platform,
    payload: 'VIS \n $v',
  );
}

DatabaseService myCall = DatabaseService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager.registerPeriodicTask(
    "5",
    simplePeriodicTask,
    existingWorkPolicy: ExistingWorkPolicy.replace,
    frequency: Duration(minutes: 15),
    initialDelay: Duration(seconds: 5),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  runApp(App());
}

void callbackDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();

    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, ios);
    flp.initialize(initSettings);

    //TODOfix the notification settinngs
    // post collection
    CollectionReference postCollections =
        Firestore.instance.collection('postData');

    QuerySnapshot blogSnapshot = await postCollections.getDocuments();

    var title;

    blogSnapshot.documents.forEach((blogPost) {
      title = blogPost.data['title'];

      return title;
    });

    showNotification(title, flp);

    return Future.value(true);
  });
}
