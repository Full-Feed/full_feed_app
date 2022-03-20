import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/models/entities/meal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/diet_provider.dart';
import '../../../utilities/constants.dart';
import '../../widgets/diet_schedule/food_detail.dart';
import '../../widgets/diet_schedule/food_option.dart';
import '../../widgets/diet_schedule/select_day_plate.dart';
import '../../widgets/diet_schedule/shimmers/food_option_shimmer.dart';

class FirstDietScreen extends StatefulWidget {

  List<Meal> meals;
  FirstDietScreen({Key? key, required this.meals}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FirstDietScreenState();

}

class FirstDietScreenState extends State<FirstDietScreen> {
  final constants = Constants();
  String date = "";
  int selected = 0;
  int foodSelected = 0;


  @override
  void initState() {

    super.initState();
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
                      onPressed: () { Navigator.pop(context); },
                      icon: Icon(CupertinoIcons.back, color: Color(constants.primaryColor),),
                    ),
                    Text("Semana 1", style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size/15),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: List.generate( 7, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                            date = DateFormat('yyyy-MM-dd').format(Provider.of<DietProvider>(context, listen: false).dietPresenter.daysForDetail[index]);
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
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          color: Colors.white
                      ),
                      height: size2/1.32,
                      width: size,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SelectDayPlate(dayMeals: Provider.of<DietProvider>(context).dietPresenter.getDayMeals(date),),
                            FoodDetail(notifyParent: refresh, meal: (Provider.of<DietProvider>(context).dayDetailPresenter.changeFood) ? Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMeal : Provider.of<DietProvider>(context).dayDetailPresenter.mealSelected),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size/20),
                              child: Row(
                                children: [
                                  Text("Opciones"),
                                  IconButton(onPressed: () {
                                    Provider.of<DietProvider>(context, listen: false).getAlternativeMeals(Provider.of<DietProvider>(context, listen: false).dayDetailPresenter.mealSelected);
                                  }, icon: Icon(CupertinoIcons.refresh_thin, color: Color(constants.primaryColor), size: size/25,))
                                ],
                              ),),
                            Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(3, (index) {
                                if(Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMealList.isNotEmpty){
                                  return GestureDetector(
                                    onTap: () {
                                      Provider.of<DietProvider>(context, listen: false).setAlternativeMeal(Provider.of<DietProvider>(context, listen: false).dayDetailPresenter.alternativeMealList[index], true);
                                    },
                                    child: FoodOption(meal: Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMealList[index]),
                                  );
                                }
                                else{
                                  return FoodOptionShimmer();
                                }
                              }),)
                          ],
                        ),
                      )
                  ),)
              ],
            ),
          )
      ),
    );
  }
}