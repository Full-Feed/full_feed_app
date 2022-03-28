
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/screens/pages/authentication/authentication_screen.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  final constants = Constants();

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/fullfeedwhite.png',
      splashIconSize: 150,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Color(constants.primaryColor),
      nextScreen: const AuthenticationScreen(),);
  }

}

