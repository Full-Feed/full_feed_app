
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/presenters/diet_day_detail_presenter.dart';
import 'package:full_feed_app/utilities//constants.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/food_detail.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/food_option.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/select_day_plate.dart';
import 'package:flutter/material.dart';


class DietDayDetail extends StatefulWidget {

  List<DateTime> daysForDetail;

  DietDayDetail({Key? key, required this.daysForDetail}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DietDayDetailState();

}

class DietDayDetailState extends State<DietDayDetail> {
  final constants = Constants();
  int selected = 0;
  late DietDayDetailPresenter presenter;

  @override
  void initState() {
    presenter = DietDayDetailPresenter();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var size2 = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size2/25, left: size/50, right: size/50),
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
                  icon: Icon(CupertinoIcons.back, color: Color(constants.calendarColor),),
                ),
                Text("Semana 1", style: TextStyle(color: Color(constants.calendarColor), fontWeight: FontWeight.bold),)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size/15),
              child: Wrap(
                direction: Axis.horizontal,
                children: List.generate(widget.daysForDetail.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected == index? Color(constants.calendarColor) : Colors.white60
                      ),
                      child: Text(presenter.setDay(widget.daysForDetail[index].weekday), style: TextStyle(fontWeight: FontWeight.bold, color: selected == index? Colors.white70 : Colors.black),),
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
                height: size2/1.35,
                width: size,
                child: Column(
                  children: [
                    SelectDayPlate(),
                    FoodDetail(plato: "plato"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size/20),
                      child: Row(
                        children: [
                          Text("Opciones"),
                          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.refresh_thin, color: Color(constants.calendarColor), size: size/25,))
                        ],
                      ),),
                    Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(3, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: FoodOption(plato: 'Avena', selected: index == selected ? true : false, ),
                        );
                      }),)
                  ],
                ),
              ),)
          ],
        ),
      ),
    );
  }
}