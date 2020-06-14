import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../model/habit.dart';
import '../model/goal.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import '../goal_page/goal_page.dart';

final notifications = FlutterLocalNotificationsPlugin();
final randomGenerator = Random();

void initNotifications(context) {
  print("init notifications");
  final settingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  Future onSelectNotification(String payload) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoalPage()),
    );
  }

  final settingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) =>
          onSelectNotification(payload));

  notifications.initialize(InitializationSettings(settingsAndroid, settingsIOS),
      onSelectNotification: onSelectNotification);
}

Future<void> showWeeklyAtDayAndTime(
    Time time, Day day, int id, Goal goal, String habitName) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show weekly channel id',
      'show weekly channel name',
      'show weekly description');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await notifications.showWeeklyAtDayAndTime(id, goal.name,
      "Reminder: $habitName", day, time, platformChannelSpecifics,
      payload: goal.id.toString());
}

Future<List<int>> updateHabitNotifications(
    Habit oldHabit, Habit newHabit, Goal goal) async {
  List<int> notificationsIDs = List<int>();
  if (oldHabit != null &&
      oldHabit.notifications == newHabit.notifications &&
      listEquals(oldHabit.notificationDays, newHabit.notificationDays) &&
      oldHabit.notificationTime.hour == newHabit.notificationTime.hour &&
      oldHabit.notificationTime.minute == newHabit.notificationTime.minute) {
    return notificationsIDs;
  }
  if (oldHabit != null) {
    for (int id in oldHabit.notificationIDs) {
      await notifications.cancel(id);
    }
  }
  if (newHabit.notifications) {
    int i = 0;
    for (bool notification in newHabit.notificationDays) {
      if (notification) {
        int id = randomGenerator.nextInt(1 << 31);
        notificationsIDs.add(id);
        await showWeeklyAtDayAndTime(
            Time(newHabit.notificationTime.hour,
                newHabit.notificationTime.minute),
            Day.values[i],
            id,
            goal,
            newHabit.name);
      }
      i++;
    }
  }
  return notificationsIDs;
}
