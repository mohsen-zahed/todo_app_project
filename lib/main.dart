import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/features/screens/home_screens/home_screen/home_screen.dart';
import 'package:to_do_list_project/config/theme/my_theme_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

const hiveBoxName = 'tasks';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskModel>(hiveBoxName);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: colors.lightPrimaryColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: colors.lightPrimaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: colors.transparentColor,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: myThemeData.lightTheme(context),
      darkTheme: myThemeData.darkTheme(context),
      home: const HomeScreen(),
    );
  }
}

final instance = FirebaseAuth.instance.signInAnonymously();
