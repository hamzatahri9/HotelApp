import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/language/appLocalizations.dart';
import 'package:flutter_hotel_booking_ui/modules/bottomTab/components/tabButtonUI.dart';
import 'package:flutter_hotel_booking_ui/modules/profile/profileScreen.dart';
import 'package:flutter_hotel_booking_ui/providers/theme_provider.dart';
import 'package:flutter_hotel_booking_ui/utils/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/common_card.dart';
import '../explore/home_Explore_Screen.dart';
import '../myTrips/MyTripsScreen.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({Key? key}) : super(key:key);

  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  BottomBarType bottomBarType = BottomBarType.Explore;
  bool _isFirstTime = true;
  Widget _indexView = Container();

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLoadingScreen();
    });
    super.initState();
  }

  Future<void> _startLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = HomeExploreScreen(
        animationController: _animationController,
      );
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) => Scaffold(
        bottomNavigationBar: Container(
          height: 60 + MediaQuery.of(context).padding.bottom,
          child: getBottomBarUI(bottomBarType),
        ),
        body: _isFirstTime
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : _indexView,
      ),
    );
  }

  Widget getBottomBarUI(BottomBarType bottomBarType) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 0,
      child: Column(
        children: [
          Row(
            children: [
              TabButtonUI(
                icon: Icons.search,
                isSelected: bottomBarType == BottomBarType.Explore,
                text: AppLocalizations(context).of("explore"),
                onTap: () {
                  tabClick(BottomBarType.Explore);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.heart,
                isSelected: bottomBarType == BottomBarType.Trips,
                text: AppLocalizations(context).of("trips"),
                onTap: () {
                  tabClick(BottomBarType.Trips);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: bottomBarType == BottomBarType.Profile,
                text: AppLocalizations(context).of("profile"),
                onTap: () {
                  tabClick(BottomBarType.Profile);
                },
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((value) => {
            if (tabType == BottomBarType.Explore)
              {
                setState(() {
                  _indexView = HomeExploreScreen(
                    animationController: _animationController,
                  );
                })
              }
            else if (tabType == BottomBarType.Trips)
              {
                setState(() {
                  _indexView = MyTripScreen(
                    animationController: _animationController,
                  );
                })
              }
            else if (tabType == BottomBarType.Profile)
              {
                setState(() {
                  _indexView = ProfileScreen(
                    animationController: _animationController,
                  );
                })
              }
          });
    }
  }
}

enum BottomBarType { Explore, Trips, Profile }
