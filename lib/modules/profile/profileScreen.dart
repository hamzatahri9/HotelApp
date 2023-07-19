import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;
  const ProfileScreen({Key? key, required this.animationController})
  : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}