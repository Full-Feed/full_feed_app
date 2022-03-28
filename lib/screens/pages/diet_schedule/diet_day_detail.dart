
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/presenters/diet_day_detail_presenter.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/screens/pages/register/welcome_screen.dart';
import 'package:full_feed_app/utilities//constants.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/food_detail.dart';

import 'package:full_feed_app/screens/widgets/diet_schedule/select_day_plate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


import '../../widgets/diet_schedule/message.dart';


class DietDayDetail extends StatefulWidget {

  bool register;
  DietDayDetail({Key? key, required this.register}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DietDayDetailState();

}

class DietDayDetailState extends State<DietDayDetail> {
  final constants = Constants();
  int selected = 0;
  int foodSelected = 0;

  @override
  void initState() {
    Provider.of<DietProvider>(context, listen: false).setDayDetailPresenter(0);
    Provider.of<DietProvider>(context, listen: false).getAlternativeMeals(Provider.of<DietProvider>(context, listen: false).dietPresenter.weekMealList.first);
    super.initState();
  }

  _showDialog(){
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (BuildContext context) {
        return Message(text: '¿Desea continuar con este plan dietético?', yesFunction: (){
          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  type: PageTransitionType.rightToLeft,
                  child: const WelcomeScreen()
              )
          );
        }, noFunction: (){}, options: true,);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  refresh(String day){
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var size2 = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size2/25, left: size/50, right: size/50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(constants.logoImagePath, width: 40,
                        height: 40, fit: BoxFit.contain),
                    Image.asset(constants.logoTextPath, width: 70,
                        height: 70, fit: BoxFit.contain)
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<DietProvider>(context, listen: false).firstDayEntry = true;
                      Navigator.pop(context); },
                    icon: Icon(CupertinoIcons.back, color: Color(constants.primaryColor),),
                  ),
                  Text("Semana 1", style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold),)
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size/15),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: List.generate( Provider.of<DietProvider>(context, listen: false).dietPresenter.daysForDetail.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                          Provider.of<DietProvider>(context, listen: false).setDayDetailPresenter(index);
                          Provider.of<DietProvider>(context, listen: false).firstDayEntry = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected == index? Color(constants.primaryColor) : Colors.white60
                        ),
                        child: Text( Provider.of<DietProvider>(context).dayDetailPresenter.setDay(Provider.of<DietProvider>(context, listen: false).dietPresenter.daysForDetail[index].weekday), style: TextStyle(fontWeight: FontWeight.bold, color: selected == index? Colors.white70 : Colors.black),),
                      ),
                    );
                  }),),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size/50, vertical: size2/80),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 2,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white
                  ),
                  height:  widget.register == true ? size2 * 1.05 : size2/1.15,
                  width: size,
                  child: Column(
                      children: [
                        SelectDayPlate(dayMeals: Provider.of<DietProvider>(context).dayDetailPresenter.dayMeals,),
                        FoodDetail( notifyParent: refresh,
                            meal: (Provider.of<DietProvider>(context).dayDetailPresenter.changeFood) ? Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMeal :
                            Provider.of<DietProvider>(context).dayDetailPresenter.mealSelected),
                        Visibility(
                          visible: widget.register == true ? true: false,
                          child: Padding(
                              padding: EdgeInsets.only(top: size2/20),
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        colors: [Color(0xFFFF295D), Color(0xFFFE7EB4)],
                                        stops: [0.05, 1]
                                    )
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showDialog();
                                  },
                                  child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: size2/20,),
                                  style: ElevatedButton.styleFrom(
                                    maximumSize: Size( 200,  200),
                                    elevation: 0,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(20),
                                    primary: Colors.transparent, // <-- Button color
                                    onPrimary: Colors.transparent, // <-- Splash color
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                ),),
            ],
          ),
        )
      ),
    );
  }
}