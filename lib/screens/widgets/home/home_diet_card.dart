import 'package:flutter/material.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:intl/intl.dart';

class HomeDietCard extends StatefulWidget {
  final Widget child;
  const HomeDietCard({required this.child, Key? key}) : super(key: key);

  @override
  _HomeDietCardState createState() => _HomeDietCardState();
}

class _HomeDietCardState extends State<HomeDietCard> {

  final constants = Constants();

  int getCurrentWeek(){
    String date = DateTime.now().toString();
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);
    int weekDay = DateTime.parse(firstDay).weekday;
    DateTime testDate = DateTime.now();
    int weekOfMonth;
    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    weekDay++;
    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    return weekOfMonth;
  }

  String getCurrentDay(String time) {
    if (time == 'Monday')
      return 'Lunes';
    else if (time == 'Tuesday')
      return 'Martes';
    else if (time == 'Wednesday')
      return 'Miércoles';
    else if (time == 'Thursday')
      return 'Jueves';
    else if (time == 'Friday')
      return 'Viernes';
    else if (time == 'Saturday')
      return 'Sábado';
    else if (time == 'Sunday')
      return 'Domingo';
    else return ' ';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 3,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                color: Color(constants.containerUpperColor)
            ),
            child: Row(
              children: [
                const Text('Semana '),
                Text(getCurrentWeek().toString(), style: const TextStyle(fontSize: 15)),
                const Spacer(),
                Padding(padding: EdgeInsets.only(right: size.width/50), child: Text(getCurrentDay(DateFormat('EEEE').format(DateTime.now())), style: const TextStyle(fontSize: 16)),),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.calendar_today, size: 35, color: Color(constants.calendarColor)),
                    Positioned(
                        top: 11,
                        child: Text(DateFormat('d').format(DateTime.now()), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
                    )
                  ],
                ),
              ],
            ),
          ),
          widget.child
        ],
      ),
    );
  }
}
