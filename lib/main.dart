import 'package:flutter/material.dart';
import 'package:flutter_curso_08_notifications_app/src/screens/screen.dart';
import 'package:flutter_curso_08_notifications_app/src/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initNotificationsService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorStateKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerStateKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    NotificationService.messageStream.listen((message) {
      navigatorStateKey.currentState?.pushReplacementNamed('message',arguments: message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification App',
      initialRoute: 'home',
      navigatorKey: navigatorStateKey,
      scaffoldMessengerKey: scaffoldMessengerStateKey,
      routes: {
        'home'    :  (_) => const HomeScreen(),
        'message' :  (_) => const MessageScreen()
      },
    );
  }
}