import 'package:product_list_task/config/theme/app_colors.dart';
import 'package:product_list_task/provider/product_list_viewmodel.dart';
import 'package:product_list_task/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
