import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../widget/second_page.dart';

final notifications = FlutterLocalNotificationsPlugin();

void initNotifications(context) {
  print("init notifications");
  final settingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
      );
  final settingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) =>
          onSelectNotification(payload));

  notifications.initialize(InitializationSettings(settingsAndroid, settingsIOS),
      onSelectNotification: onSelectNotification);
}
