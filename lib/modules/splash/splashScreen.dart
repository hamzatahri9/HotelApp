import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_ui/language/appLocalizations.dart';
import 'package:flutter_hotel_booking_ui/providers/theme_provider.dart';
import 'package:flutter_hotel_booking_ui/routes/route_names.dart';
import 'package:flutter_hotel_booking_ui/utils/localfiles.dart';
import 'package:flutter_hotel_booking_ui/utils/text_styles.dart';
import 'package:flutter_hotel_booking_ui/utils/themes.dart';
import 'package:flutter_hotel_booking_ui/widgets/common_button.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoadText = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadApplicationLocalization());
    super.initState();
  }

  Future<void> _loadApplicationLocalization() async {
    try {
      setState(() {
        isLoadText = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: !AppTheme.isLightMode
                ? BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.4),
                  )
                : null,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              Localfiles.introduction,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).dividerColor,
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Image.asset(Localfiles.appIcon),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Nice Place",
                textAlign: TextAlign.left,
                style: TextStyles(context).getBoldStyle().copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 8,
              ),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 420),
                child: Text(
                  AppLocalizations(context).of("find_best_deals"),
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getRegularStyle().copyWith(),
                ),
              ),
              const Expanded(
                flex: 4,
                child: SizedBox(),
              ),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0 ,
                duration: const Duration(milliseconds: 680),
                child: CommonButton(
                  padding: const EdgeInsets.only(
                    left: 48, right: 48, bottom: 8, top: 8),
                  buttonText: AppLocalizations(context).of("get_started"),
                  onTap: (){
                   NavigationServices(context).goToIntroductionScreen();
                  },
                )),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 680),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                    top: 16,
                  ),
                  child: Text(
                    AppLocalizations(context).of("already_have_account"),
                    textAlign: TextAlign.left,
                    style: TextStyles(context)
                    .getDescriptionStyle()
                    .copyWith(color: AppTheme.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
