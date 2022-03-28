

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../utilities/constants.dart';
import '../diet_schedule/diet_day_detail.dart';

class LoadingScreen extends StatefulWidget {
  String text;
  bool register;
  LoadingScreen({Key? key, required this.text, required this.register}) : super(key: key);

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  final constants = Constants();
  int currentIndex = 0;

  late AnimationController controller;
  late Animation<double> innerAnimation;
  late Animation<double> externalAnimation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    innerAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    externalAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    super.initState();
    if(widget.register){
      Provider.of<DietProvider>(context, listen: false).initDietPresenter(context, null);
      register();
    }
    controller.repeat();
  }

  register(){
    Provider.of<DietProvider>(context, listen: false).generateNutritionPlan(UserSession().profileId, Provider.of<UserProvider>(context, listen: false).registerPresenter.doctorId, context).then((value){
      if(value){
        controller.stop();
        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: DietDayDetail(register: true,)
            )
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height/80),
              child: Text(
                widget.text,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height/4),
              child: RotationTransition(
                turns: innerAnimation,
                child: SvgPicture.asset(constants.innerCircle, width: size.width/4.5,),
              ),),
            Padding(
               padding: EdgeInsets.only(top: size.height/4),
               child: RotationTransition(
                 turns: externalAnimation,
                 child: SvgPicture.asset(constants.externalCircle, width: size.width/3),
               ))
          ],
        ),
      ],
    );
  }
}