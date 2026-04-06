import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width ,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 40),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/SplashScreenvhvhpng.png",
            ),
          ),
          
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Zariya Jewels",style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}