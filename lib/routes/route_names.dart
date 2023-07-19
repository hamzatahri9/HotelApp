import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/modules/bottomTab/bottomTabScreen.dart';
import 'package:flutter_hotel_booking_ui/modules/hotel_details/search_screen.dart';
import 'package:flutter_hotel_booking_ui/modules/login/forgot_password.dart';
import 'package:flutter_hotel_booking_ui/modules/login/login_Screen.dart';
import 'package:flutter_hotel_booking_ui/modules/login/sign_up_Screen.dart';
import 'package:flutter_hotel_booking_ui/routes/routes.dart';

class NavigationServices {
  final BuildContext context;
  NavigationServices(this.context);

  Future<dynamic> _pushMaterilPageRoute (Widget widget,
    {bool fullscreenDialog: false}) async {
      return await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog
        )
      );
    }

    void goToIntroductionScreen(){
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.IntroductionScreen, 
      (Route<dynamic> route) => false);
    }

    Future<dynamic> gotoLoginScreen() async {
      return await _pushMaterilPageRoute(const LoginScreen());
    }

    Future<dynamic> gotoForgotPasswordScreen() async {
      return await _pushMaterilPageRoute(const ForgotPassword());
    }

    Future<dynamic> gotoSignUpScreen() async {
      return await _pushMaterilPageRoute(const SignUpScreen());
    }

    Future<dynamic> gotoBottomTabScreen() async {
      return await _pushMaterilPageRoute(const BottomTabScreen());
    }

    Future<dynamic> gotoSearchScreen() async {
      return await _pushMaterilPageRoute(SearchScreen());
    }
  }
