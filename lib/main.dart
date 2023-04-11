import 'package:flutter/material.dart';
//import 'package:flutter_todo_list/controllers/global_bindings.dart';
import 'package:flutter_todo_list/login_page.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  Paint.enableDithering = true;
  await Hive.initFlutter();
  await Hive.openBox("todos");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLoginPage(),
    );
  }
}
