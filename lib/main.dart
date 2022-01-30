import 'package:flutter/material.dart';
import 'package:foody/model/product_model.dart';
import 'package:foody/screen/detail_screen.dart';
import 'package:foody/screen/home_screen.dart';
import 'package:foody/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foody',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
              product:
                  ModalRoute.of(context)?.settings.arguments as ProductModel,
            ),
      },
    );
  }
}
