// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/language/appLocalizations.dart';
import 'package:flutter_hotel_booking_ui/modules/splash/components/page_pop_view.dart';
import 'package:flutter_hotel_booking_ui/providers/theme_provider.dart';
import 'package:flutter_hotel_booking_ui/utils/enum.dart';
import 'package:flutter_hotel_booking_ui/utils/localfiles.dart';
import 'package:flutter_hotel_booking_ui/utils/text_styles.dart';
import 'package:flutter_hotel_booking_ui/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const HomeExploreSliderView({
    Key? key,
    required this.opValue,
    required this.click,
  }) : super(key: key);

  @override
  State<HomeExploreSliderView> createState() => _HomeExploreSliderViewState();
}

class _HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewData = [];
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewData.add(PageViewData(
      titleText: 'Lesperence',
      subText: 'five_star',
      assetsImage: Localfiles.explore_2,
    ));
    pageViewData.add(PageViewData(
      titleText: 'Lesperence',
      subText: 'five_star',
      assetsImage: Localfiles.explore_1,
    ));
    pageViewData.add(PageViewData(
      titleText: 'Lesperence',
      subText: 'five_star',
      assetsImage: Localfiles.explore_3,
    ));
    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (mounted) {
        if (currentShowIndex == 0) {
          pageController.animateTo(
            MediaQuery.of(context).size.width,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        } else if (currentShowIndex == 1) {
          pageController.animateTo(
            MediaQuery.of(context).size.width * 2,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        } else if (currentShowIndex == 2) {
          pageController.animateTo(
            0,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children:<Widget> [
          PageView.builder(
            controller: pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            itemCount: pageViewData.length,
            itemBuilder:(BuildContext context, int index){
              return PagePopup(
                 imageData: pageViewData[index],
                 opValue: widget.opValue,
               );
            }),
          Positioned(
            bottom: 32,
            right: context.read<ThemeProvider>().languageType == LanguageType.ar 
            ? null 
            : 32,
            left: context.read<ThemeProvider>().languageType == LanguageType.ar 
            ? 32 
            : null,
            child: SmoothPageIndicator(
              controller: pageController,
              count: pageViewData.length,
              effect: WormEffect(
                activeDotColor: Theme.of(context).primaryColor,
                dotColor: Colors.white,
                dotHeight: 7.0,
                dotWidth: 7.0,
                spacing: 5.0,
              ),
              onDotClicked: (index) {}),
            )
        ]),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;
  const PagePopup({super.key, required this.imageData, required this.opValue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 1.3,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imageData.assetsImage,
            fit: BoxFit.cover
            ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Opacity(
            opacity: opValue,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    AppLocalizations(context).of(imageData.titleText),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getTitleStyle().copyWith(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                 ),
                 SizedBox(
                  height: 8,
                  ),
                Container(
                  child: Text(
                    AppLocalizations(context).of(imageData.subText),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getRegularStyle().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.whiteColor,
                    ),
                 )),
                 SizedBox(
                  height: 16,
                 ),
              ],
            )
          ))
      ],
    );
  }
}