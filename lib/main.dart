import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/Models/fetchVideo.dart';
import 'package:youtube_clone/Models/homePageModel.dart';
import 'package:youtube_clone/Util/constants.dart';
import 'Screens/MainScreen.dart';
import 'Screens/SplashScreen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomePageModel(),),
      ChangeNotifierProvider(create: (context) => fetchVideo(),)
    ],child: const MyApp(),)
   
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: constants.appName,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.blue,
        ),
        scrollbarTheme:  const ScrollbarThemeData(
          thumbVisibility: WidgetStatePropertyAll(kIsWeb?true:false),
          thickness: WidgetStatePropertyAll(5),
          thumbColor: WidgetStatePropertyAll(Colors.white)
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const SpalshScreen(),
    );
  }
}


