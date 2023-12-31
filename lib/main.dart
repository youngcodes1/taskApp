import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:taskmasta/Provider/bottomnav_provider.dart';
import 'package:taskmasta/Provider/chart_provider.dart';
import 'package:taskmasta/Provider/task_provider.dart';
import 'package:taskmasta/Provider/utils_provider.dart';

import 'BoxStorage/boxstorage.dart';
import 'Provider/theme_provider.dart';
import 'Provider/user_provider.dart';
import 'Screens/Pages/pages_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BoxStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UtilsProvider()),
        ChangeNotifierProvider(create: (_) => ChartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Builder(
        builder: (context) {
          // Use context from Builder to access the ThemeProvider
          ThemeData themeData = Provider.of<ThemeProvider>(context).themeData;

          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: themeData.copyWith(
              useMaterial3: true,
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );

    // ThemeData(
    // This is the theme of your application.
    //
    // TRY THIS: Try running your application with "flutter run". You'll see
    // the application has a blue toolbar. Then, without quitting the app,
    // try changing the seedColor in the colorScheme below to Colors.green
    // and then invoke "hot reload" (save your changes or press the "hot
    // reload" button in a Flutter-supported IDE, or press "r" if you used
    // the command line to start the app).
    //
    // Notice that the counter didn't reset back to zero; the application
    // state is not lost during the reload. To reset the state, use hot
    // restart instead.
    //
    // This works for code too, not just values: Most code changes can be
    // tested with just a hot reload.
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    // useMaterial3: true,
    // fontFamily: 'Baloo2'),
    //     home: const SplashScreen(),
    //     debugShowCheckedModeBanner: false,
    //   ),
    // ),
    // );
  }
}
