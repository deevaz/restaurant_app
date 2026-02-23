import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reastaurant_app/data/db/database_helper.dart';
import 'package:reastaurant_app/data/preferences/preferences_helper.dart';
import 'package:reastaurant_app/provider/bottom_nav_provider.dart';
import 'package:reastaurant_app/provider/database_provider.dart';
import 'package:reastaurant_app/provider/preference_provider.dart';
import 'package:reastaurant_app/provider/scheduling_provider.dart';
import 'package:reastaurant_app/ui/home_page.dart';
import 'package:reastaurant_app/ui/restaurant_detail_page.dart';
import 'package:reastaurant_app/ui/restaurant_search_page.dart';
import 'package:reastaurant_app/utils/background_service.dart';
import 'package:reastaurant_app/utils/notification_helper.dart';
import 'package:reastaurant_app/utils/permission_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'common/styles.dart';
import 'package:provider/provider.dart';
import 'package:reastaurant_app/common/navigation.dart';
import 'data/api/api_service.dart';
import 'provider/restaurant_provider.dart';
import 'provider/search_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    PermissionHelper.requestNotificationPermission();
    _notificationHelper.configureSelectNotificationSubject(
      RestaurantDetailPage.routeName,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,

            theme: RestaurantTheme.lightTheme,
            darkTheme: RestaurantTheme.darkTheme,
            themeMode: provider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

            home: const HomePage(),
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              RestaurantSearchPage.routeName: (context) =>
                  const RestaurantSearchPage(),
              RestaurantDetailPage.routeName: (context) {
                final id = ModalRoute.of(context)?.settings.arguments as String;
                return RestaurantDetailPage(id: id);
              },
            },
          );
        },
      ),
    );
  }
}
