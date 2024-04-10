import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loggin_screen/Screens/login.dart';
import 'package:loggin_screen/Screens/loginSuccess.dart';
import 'package:loggin_screen/Services/pocketbase.dart';
import 'package:loggin_screen/hive/LoginBox.dart';
import 'package:loggin_screen/model/prefs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  // Directory dir = await pathProvider.getApplicationDocumentsDirectory();
   Hive.init(appDocumentsDir.path);
  //  Hive.initFlutter(appDocumentsDir.path);

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(AuthRecordModelBoxtypeAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the custom primary color
    // late final authStore;
    // late final authtoken;
    // late final pref;

    // getAuth() async {
    //   pref =await SharedPreferences.getInstance();
    //   authStore = await pref.getString(PrefKeys.accessTokenPrefsKey, " ");
    // }
    final pocketbase = PocketBaseAuthClass();
    pocketbase.init();
    final Color customPrimaryColor = Color.fromRGBO(0, 0, 54, 1);

    // Create a MaterialColor from the custom primary color
    MaterialColor customPrimaryMaterialColor =
        createMaterialColor(customPrimaryColor);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: customPrimaryMaterialColor,
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: customPrimaryMaterialColor),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,

      home: Myhome(),
    );
  }

  // Function to create a MaterialColor from a given color
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  String? token;
  Future<void> getpref() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString(PrefKeys.accessTokenPrefsKey);
    });

    print("at main:: token:$token");
  }

  @override
  void initState() {
    // TODO: implement initState
    getpref();
    print("after token:$token");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final pbauthclass = PocketBaseAuthClass();
    // final bool isAuth = pbauthclass.isAuth;
    // print(isAuth);
    if (token != null) {}
    return token != null ? LoginSuccess() : LoginScreen();
  }
}
