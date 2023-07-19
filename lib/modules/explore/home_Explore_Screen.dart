import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/language/appLocalizations.dart';
import 'package:flutter_hotel_booking_ui/models/hotel_list_data.dart';
import 'package:flutter_hotel_booking_ui/modules/explore/home_explore_slider_view.dart';
import 'package:flutter_hotel_booking_ui/modules/explore/hotel_list_view_page.dart';
import 'package:flutter_hotel_booking_ui/modules/explore/popular_list_view.dart';
import 'package:flutter_hotel_booking_ui/modules/explore/title_view.dart';
import 'package:flutter_hotel_booking_ui/providers/theme_provider.dart';
import 'package:flutter_hotel_booking_ui/routes/route_names.dart';
import 'package:flutter_hotel_booking_ui/widgets/bottom_top_move_animation_view.dart';
import 'package:flutter_hotel_booking_ui/widgets/common_button.dart';
import 'package:flutter_hotel_booking_ui/widgets/common_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_search_bar.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;
  HomeExploreScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  _HomeExploreScreenState createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen>
 with TickerProviderStateMixin{
  var hotelList = HotelListData.hotelList;
  late ScrollController controller;
  late AnimationController _animationController;
  var sliderImageHeight = 0.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 0));
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
      if(mounted){
        if(controller.offset< 0){
          //set a static value below half scrolling values 
          _animationController.animateTo(0.0);
        }else if(controller.offset > 0.0 && controller.offset < sliderImageHeight){
          //we need around half scrolling values 
          if(controller.offset < ((sliderImageHeight / 1.5 ))){
            _animationController.animateTo((controller.offset / sliderImageHeight));
          }else {
            _animationController.animateTo(((sliderImageHeight / 1.5) / sliderImageHeight));
          }
        }
      }
    });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHeight = MediaQuery.of(context).size.width * 1.3;
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
       child: Consumer<ThemeProvider>(
          builder: (context, value, child) => Stack(
            children: [
              Container(
                color: AppTheme.scaffoldBackgroundColor,
                child: ListView.builder(
                  controller: controller,
                  itemCount: 4,
                  padding: EdgeInsets.only(top: sliderImageHeight + 32,bottom: 16),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index){
                    var count = 4;
                    var animation = Tween(begin : 0.0,end:1.0).animate(
                      CurvedAnimation(
                        parent: widget.animationController,
                        curve: Curves.fastOutSlowIn),
                        );
                        if(index == 0){
                          return TitleView(
                            titleText: AppLocalizations(context).of("popular_destination"),
                            animationController: widget.animationController, 
                            animation: animation, 
                            isLeftButton: true,
                            click: (){}, subTxt: 'yo',);
                        } else if(index == 1){
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: PopularListView(
                              animationController: widget.animationController,
                              callBack: (index) {},
                            ),
                            );
                        } else if(index == 2){
                          return TitleView(
                            titleText: AppLocalizations(context).of("best_deal"),
                            subTxt: AppLocalizations(context).of("view_all") ,
                            animationController: widget.animationController, 
                            animation: animation, 
                            isLeftButton: true,
                            click: (){});
                        } else {
                          return getDealListView(index);
                        }
                  }),
              ),
              //Animated slider UI
              _sliderUI(),
              // View Hotel Bottom Ui for On click event
              _viewHotelButton(_animationController),

              //Search Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration:BoxDecoration(
                    gradient:LinearGradient(
                      colors: [
                        Theme.of(context).backgroundColor.withOpacity(0.4),
                        Theme.of(context).backgroundColor.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ) ,
                ),
              ),
              Positioned(
                top:MediaQuery.of(context).padding.top,
                left:0,
                right:0,
                child: searchUI(),
                )
            ],
          )
          ),
       );
  }
  
  _sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,

      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child ){
          var opecity = 1.0 - 
            (_animationController.value > 0.64 
            ? 1.0 
            : _animationController.value);
          return SizedBox(
            height: sliderImageHeight * ( 1.0 - _animationController.value),
            child: HomeExploreSliderView(
                opValue: opecity,
                click: () {},
             )
            );
        }));
  }
  
  _viewHotelButton(AnimationController animationController) {
    return AnimatedBuilder(animation: animationController,
    builder: (BuildContext context, Widget? child){
      var opecity = 1.0 - 
            (_animationController.value > 0.64 
            ? 1.0 
            : _animationController.value);
          return Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: sliderImageHeight * (1.0 - _animationController.value),
            child: Stack(
              children: [
                Positioned(
                  bottom: 32,
            right: context.read<ThemeProvider>().languageType == LanguageType.ar 
            ? 24 
            : null,
            left: context.read<ThemeProvider>().languageType == LanguageType.ar 
            ? null
            : 24,
                  child: Opacity(
                    opacity:opecity,
                    child: CommonButton(
                      onTap: () {
                        if(opecity != 0){
                          Scaffold();
                        }
                      },
                      buttonTextWidget: Padding(
                        padding:EdgeInsets.only(left: 24,right: 24,top:8,bottom: 8),
                        child:Text(
                          AppLocalizations(context).of("view_hotel"),
                          style: TextStyles(context).getTitleStyle().copyWith(
                          color: AppTheme.whiteColor,
                    ),
                        )),
                    ),
                    ),
                  )
              ],
            ),
            );
    });
  }
  
  searchUI() {
    return Padding(
      padding: EdgeInsets.only(left:24,right: 24,top:16),
      child: CommonCard(
        radius: 36,
        child: InkWell(
          borderRadius:BorderRadius.all(Radius.circular(30)),
          onTap: () {
            NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: FontAwesomeIcons.search,
            enabled: false,
            text: AppLocalizations(context).of("where_are_you_going"),
          ),
      ),
     ),
    );
  }
  
  Widget getDealListView(int index) {
    var hotelList = HotelListData.hotelList;
    List<Widget> list = [];
    hotelList.forEach((element) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController, curve: Interval(0,1.0,curve: Curves.fastOutSlowIn),
        )
      );
      list.add(
        HotelListViewPage(
          callback: (){}, 
          hotelData: element , 
          animation: animation,
          animationController: widget.animationController,
          ),
      );
    });
    return Padding(
      padding: const EdgeInsets.only(top:8),
      child: Column(
        children: list,
      ),
    );
  }
}