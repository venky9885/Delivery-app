import 'package:flutter/material.dart';
import './providers/app_state.dart';
import './providers/user.dart';
import './screens/login.dart';
import './screens/splash.dart';
import 'locators/service_locator.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppStateProvider>.value(
        value: AppStateProvider(),
      ),
      ChangeNotifierProvider<UserProvider>.value(
        value: UserProvider.initialize(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Txapita',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return MyHomePage();
      default:
        return LoginScreen();
    }
  }
}
