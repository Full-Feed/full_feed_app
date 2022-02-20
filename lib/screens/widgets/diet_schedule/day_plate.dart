
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class DayPlate extends StatefulWidget {

  String plato;
  bool selected;

  DayPlate({Key? key, required this.plato, required this.selected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DayPlateState();

}

class DayPlateState extends State<DayPlate> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size/50, vertical: 5),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: size2/90),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.selected == true ? Color(constants.selectedColor) : Colors.white,
          ),
          width: size/2.6,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: size/30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Desayuno", style: TextStyle(fontSize: size/40, fontWeight: FontWeight.w600),),
                        Image.asset(constants.breakfastImg, width: 40,
                            height: 20, fit: BoxFit.contain),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10), child: Text(widget.plato, style: TextStyle(fontSize: size/35, fontWeight: FontWeight.w200),),)
                  ],
                ),),
              Checkbox(
                  value: widget.selected,
                  checkColor: Color(constants.selectedColor),
                  fillColor: MaterialStateProperty.all(Color(constants.calendarColor),),
                  activeColor: Color(constants.calendarColor),
                  shape: const CircleBorder(),
                  onChanged: null),
            ],
          )
      ),);
  }
}