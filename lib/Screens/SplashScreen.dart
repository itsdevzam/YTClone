import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/Screens/MainScreen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/logos/yt_logo.png",width: 600,height: 400,),
      ),
    );
  }
  @override
  void initState() {
    Future.delayed(const Duration(seconds: kIsWeb?0:2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepage(),));
    });
    super.initState();
  }
}
