import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';


import 'day_plate.dart';

class SelectDayPlate extends StatefulWidget {


  SelectDayPlate({Key? key}) : super(key: key);

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
    return Padding(padding: EdgeInsets.symmetric(vertical: size2/50),
      child: Wrap(
        direction: Axis.horizontal,
        children: List.generate(5, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
              });
            },
            child: DayPlate(plato: 'Avena', selected: index == selected ? true : false, ),
          );
        }),),);
  }
}