import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;

    if (status.isDenied) {
      await Permission.notification.request();
    }
  }
}
