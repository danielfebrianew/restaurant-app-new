import 'package:flutter/material.dart';
import 'package:resto_app_new/common/styles.dart';
import 'package:resto_app_new/data/db/preferences_helper.dart';
import 'package:resto_app_new/ui/home_page.dart';
import 'package:resto_app_new/ui/login_page.dart';
import 'package:resto_app_new/ui/profile_page.dart';
import 'package:resto_app_new/ui/register_page.dart';
import 'package:resto_app_new/ui/resto/restaurant_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesHelper preferencesHelper = PreferencesHelper();
  bool isLoggedIn = await preferencesHelper.isLoggedIn;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cari Restoran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: secondaryColor,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: isLoggedIn ? HomePage.routeName : LoginPage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        ProfilePage.routeName: (_) => const ProfilePage(),
        LoginPage.routeName: (_) => const LoginPage(),
        RestaurantListPage.routeName: (_) => const RestaurantListPage(),
        RegisterPage.routeName: (_) => const RegisterPage(),
      },
    );
    // );
  }
}
