
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/entities/meal.dart';

class DayPlate extends StatefulWidget {

  Meal meal;
  bool selected;

  DayPlate({Key? key, required this.meal, required this.selected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DayPlateState();

}

class DayPlateState extends State<DayPlate> {
  final constants = Constants();
  late bool completed;

  @override
  void initState() {
    if(widget.meal.status != 0){
      completed = true;
    }
    else{
      completed = false;
    }
    super.initState();
  }

  setDay(int day){
    String dayName = "";
    switch(day){
      case 1:
        dayName = "Lun";
        break;
      case 2:
        dayName = "Mar";
        break;
      case 3:
        dayName = "Mie";
        break;
      case 4:
        dayName = "Jue";
        break;
      case 5:
        dayName = "Vie";
        break;
      case 6:
        dayName = "Sab";
        break;
      case 7:
        dayName = "Dom";
        break;
    }
    return dayName;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var size2 = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size/60, vertical: 5),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: size2/90),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.selected == true ? Color(constants.selectedColor) : Colors.white,
          ),
          width: size/2.5,
          child: Stack(
            children: [
              Padding(padding: EdgeInsets.only(left: size/40),
                child: SizedBox(
                  width: size/3.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Provider.of<DietProvider>(context).homePresenter.setFoodDayName(widget.meal.schedule.toString()), style: TextStyle(fontSize: size/40, fontWeight: FontWeight.w600),),
                          Image.asset(constants.breakfastImg, width: 30,
                              height: 20, fit: BoxFit.contain),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: size/4,
                          child: Text(
                            widget.meal.name.toString(),
                            style: TextStyle(fontSize: size/35, fontWeight: FontWeight.w200, overflow: TextOverflow.ellipsis),),
                        ),)
                    ],
                  ),
                ),),
              Align(
                alignment: Alignment.centerRight,
                child: Checkbox(
                    value: completed,
                    checkColor: Color(constants.selectedColor),
                    fillColor: MaterialStateProperty.all(Color(constants.primaryColor),),
                    activeColor: Color(constants.primaryColor),
                    shape: const CircleBorder(),
                    onChanged: (value){
                      if(UserSession().rol == 'p'){
                        if(completed == false){
                          Provider.of<DietProvider>(context, listen: false).completeMeal(widget.meal.mealId!).then((value){
                            setState(() {
                              completed = value;
                            });
                          });
                        }
                        else{
                          Provider.of<DietProvider>(context, listen: false).restoreMeal(widget.meal.mealId!).then((value){
                            setState(() {
                              completed = value;
                            });
                          });
                        }
                      }
                    }),
              ),
            ],
          )
      ),);
  }
}