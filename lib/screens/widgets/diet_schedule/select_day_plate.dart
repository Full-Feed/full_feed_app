import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../models/entities/meal.dart';
import 'day_plate.dart';

class SelectDayPlate extends StatefulWidget {

  List<Meal> dayMeals;
  SelectDayPlate({Key? key, required this.dayMeals}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SelectDayPlateState();

}

class SelectDayPlateState extends State<SelectDayPlate> {
  final constants = Constants();
  int selected = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(padding: EdgeInsets.symmetric(vertical: size.height/50),
      child: Wrap(
        direction: Axis.horizontal,
        children: List.generate(widget.dayMeals.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
                Provider.of<DietProvider>(context, listen: false).setMealSelected(widget.dayMeals[selected]);
              });
            },
            child: DayPlate(meal: widget.dayMeals[index], selected: index == selected ? true : false, ),
          );
        }),),);
  }
}