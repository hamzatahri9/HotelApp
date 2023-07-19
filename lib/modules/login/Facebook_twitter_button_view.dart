import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/utils/text_styles.dart';
import 'package:flutter_hotel_booking_ui/widgets/common_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookTwitterButtonView extends StatelessWidget {
  const FacebookTwitterButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const SizedBox(
            width: 24, 
            ),
            Expanded(
              child: CommonButton(
                padding: EdgeInsets.zero,
                backgroundColor: Color(0x0FF3C5799),
                buttonTextWidget: _buttonTextUI(),
              ),
            ),
            const SizedBox(
            width: 24, 
            ),
            Expanded(
              child: CommonButton(
                padding: EdgeInsets.zero,
                backgroundColor: Color(0x0FF05A9F0),
                buttonTextWidget: _buttonTextUI(isFaceBook: false),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
        ],
      )
    );
  }

 Widget _buttonTextUI({bool isFaceBook : true}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(isFaceBook ? FontAwesomeIcons.facebookF : FontAwesomeIcons.twitter,
      size: 20,
      color: Colors.white,  
       ),
      const SizedBox(
        width: 24,
       ),
       Text( isFaceBook ? "Facebook" : "Twitter",
       style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize:16,
        color: Colors.white,
        ),
      )
    ],
  );
 } 

}