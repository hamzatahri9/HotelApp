import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/modules/login/Facebook_twitter_button_view.dart';
import 'package:flutter_hotel_booking_ui/routes/route_names.dart';
import 'package:flutter_hotel_booking_ui/utils/text_styles.dart';
import 'package:flutter_hotel_booking_ui/utils/themes.dart';
import 'package:flutter_hotel_booking_ui/widgets/common_textfield_view.dart';

import '../../language/appLocalizations.dart';
import '../../utils/validator.dart';
import '../../widgets/common_appbar_view.dart';
import '../../widgets/common_button.dart';
import '../../widgets/remove_focuse.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key ? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _errorEmail = '';
  TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  TextEditingController _passwordController = TextEditingController();
  String _errorFName = '';
  TextEditingController _fnameController = TextEditingController();
  String _errorLName = '';
  TextEditingController _lnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
      onClick: () {
        FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back_ios_new,
              titleText: AppLocalizations(context).of("sign_up"),
              onBackClick: () {
                Navigator.pop(context);
              }),
            Expanded(
              child:SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                         top: 32,left: 16, right: 16,bottom: 16),
                      child: FacebookTwitterButtonView(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations(context).of("log_with mail"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    CommonTextFieldView(
                      controller: _fnameController,
                      errorText: _errorFName,
                      titleText: AppLocalizations(context).of("first_name"),
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      hintText: AppLocalizations(context).of("enter_first_name"),
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      controller: _lnameController,
                      errorText: _errorLName,
                      titleText: AppLocalizations(context).of("last_name"),
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 15,
                        ),
                      hintText: AppLocalizations(context).of("enter_last_name"),
                      onChanged: (String txt) {},
                      keyboardType: TextInputType.name,
                      isObsecureText: false,
                    ),
                    CommonTextFieldView(
                      controller: _emailController,
                      errorText: _errorEmail,
                      titleText: AppLocalizations(context).of("your_mail"),
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 15,
                      ),
                      hintText: AppLocalizations(context).of("enter_your_email"),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      controller: _passwordController,
                      errorText: _errorPassword,
                      titleText: AppLocalizations(context).of("password"),
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 24,
                        ),
                      hintText: AppLocalizations(context).of("enter_password"),
                      onChanged: (String txt) {},
                      keyboardType: TextInputType.text,
                      isObsecureText: true,
                    ),
                    CommonButton(
                      padding: EdgeInsets.only(top: 24, left: 24,right: 24,bottom: 16),
                      buttonText: AppLocalizations(context).of("sign_up"),
                      onTap: () {
                       if (allValidation()) {
                          NavigationServices(context).gotoBottomTabScreen();
                          }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations(context).of("terms_agreed"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        AppLocalizations(context).of("already_have_account"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        onTap: () {
                          NavigationServices(context).gotoLoginScreen();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            AppLocalizations(context).of("login"),
                            style: TextStyles(context).getRegularStyle().copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ), 
                          ),
                        ),
                     ],
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 24 ,
                    )
                  ],
                ) ,
              ),     
            ),
          ],
        )
    ));
  }
    bool allValidation() {
   bool isValid = true;

  if (_fnameController.text.trim().isEmpty) {
    _errorFName = AppLocalizations(context).of('first_name_cannot_empty');
    isValid = false;
  }else {
    _errorFName = '';
  }
  if (_lnameController.text.trim().isEmpty) {
    _errorLName = AppLocalizations(context).of('last_name_cannot_empty');
    isValid = false;
  }else {
    _errorLName = '';
  }

  if (_emailController.text.trim().isEmpty) {
    _errorEmail = AppLocalizations(context).of('email_cannot_empty');
    isValid = false;
  } else if (!Validator.validateEmail(_emailController.text.trim())) {
    _errorEmail = AppLocalizations(context).of('enter_valid_email');
    isValid = false;
  } else {
    _errorEmail = '';
  }

  if (_passwordController.text.trim().isEmpty) {
    _errorPassword = AppLocalizations(context).of('password_cannot_empty');
    isValid = false;
  } else if (_passwordController.text.trim().length < 6) {
    _errorPassword = AppLocalizations(context).of('valid_password');
    isValid = false;
  } else {
    _errorPassword = '';
  }
  setState(() {
    
  });
  return isValid;
}
}