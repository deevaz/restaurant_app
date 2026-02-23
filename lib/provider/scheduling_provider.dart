import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:reastaurant_app/data/preferences/preferences_helper.dart';
import 'package:reastaurant_app/utils/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyReminderPreference();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getDailyReminderPreference() async {
    _isScheduled = await preferencesHelper.isDailyReminderActive;
    if (_isScheduled) {
      scheduledNews(true);
    }
    notifyListeners();
  }

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    preferencesHelper.setDailyReminder(value);
    notifyListeners();

    if (_isScheduled) {
      print('Scheduling Activated');

      await Workmanager().registerPeriodicTask(
        taskName,
        taskName,
        frequency: const Duration(hours: 24),
        initialDelay: const Duration(seconds: 10),
        constraints: Constraints(networkType: NetworkType.connected),
      );
      return true;
    } else {
      print('Scheduling Canceled');
      await Workmanager().cancelByUniqueName(taskName);
      return true;
    }
  }
}
