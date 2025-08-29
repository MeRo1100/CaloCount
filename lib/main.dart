import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ketodiet/model/hive/userdata/breakfastmodel/breakfastmodel.dart';
import 'package:ketodiet/model/hive/userdata/userdatamodel.dart';
import 'package:ketodiet/screens/splash_screen/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(UserDataModelAdapter());
  Hive.registerAdapter(BreakFastModelAdapter());
  await Hive.openBox('userdata');
  await Hive.openBox('breakfastData');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calo Count',
      debugShowCheckedModeBanner: false,
      home: SplashScreen.SplashScreen(),
    );
  }
}
