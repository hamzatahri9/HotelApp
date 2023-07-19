import 'package:flutter/material.dart';

class MyTripScreen extends StatefulWidget {
  final AnimationController animationController;
  const MyTripScreen({Key? key, required this.animationController}) 
    : super(key:key);

  @override
  State<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends State<MyTripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Text("My Favorite Trips"),
      ),
    );
  }
}