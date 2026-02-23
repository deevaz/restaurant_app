import 'dart:ui';
import 'dart:isolate';
import 'package:workmanager/workmanager.dart';
import 'package:reastaurant_app/data/api/api_service.dart';
import 'package:reastaurant_app/utils/notification_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final ReceivePort port = ReceivePort();
const String taskName = "daily_reminder";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      print("Background Task Executed: $task");
      final apiService = ApiService();
      final notificationHelper = NotificationHelper();

      final result = await apiService.getList();

      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin,
        result,
      );

      return Future.value(true);
    } catch (e) {
      print("Background Task Failed: $e");
      return Future.value(false);
    }
  });
}

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }
}
