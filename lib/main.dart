import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/addnewtaskscreen.dart';
import 'screens/splashscreen.dart';
import 'provider/dataprovider.dart';
import 'screens/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderClass()),
      ],
      child: MaterialApp(
        title: 'ToDo App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MySplashScreen(),
          '/homescreen': (context) => const MyHomeScreen(),
          '/addnewtaskscreen': (context) => const MyAddNewTaskScreen(),
        },
      ),
    );
  }
}
