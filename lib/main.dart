import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moovbe/Utils/Globals.dart';
import 'package:moovbe/providers/driverProvider.dart';
import 'package:moovbe/user_interface/driverList.dart';
import 'package:moovbe/user_interface/home.dart';
import 'package:provider/provider.dart';
import 'user_interface/addDriver.dart';
import 'user_interface/busDetails.dart';
import 'user_interface/login.dart';
import 'user_interface/splashScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DriverProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'moovbe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const splashPage(),
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          HomePage.routeName: (context) => HomePage(),
          BusDetails.routeName: (context) => BusDetails(),
          DriverListScreen.routeName: (context) => DriverListScreen(),
          addDriver.routeName: (context) => addDriver(),
          splashPage.routeName: (context) => splashPage(),
        },
      ),
    );
  }
}
