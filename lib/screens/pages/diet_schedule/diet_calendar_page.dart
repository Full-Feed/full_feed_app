
import 'package:full_feed_app/presenters/diet_calendar_presenter.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'diet_day_detail.dart';

class DietCalendarPage extends StatefulWidget {
  const DietCalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DietCalendarPageState();

}

class DietCalendarPageState extends State<DietCalendarPage> {
  final constants = Constants();
  late BasicDietCalendarPresenter presenter;
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    presenter = BasicDietCalendarPresenter(context, _controller);
    presenter.setCalendar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SfDateRangePicker(
          controller: _controller,
          onSelectionChanged: presenter.getWeek,
          showNavigationArrow: false,
          headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(color: Color(constants.calendarColor), fontWeight: FontWeight.bold, fontSize: 18)),
          view: DateRangePickerView.month,
          monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: presenter.dietFirstDay, numberOfWeeksInView: 6, showTrailingAndLeadingDates: true, enableSwipeSelection: false),
          selectionMode: DateRangePickerSelectionMode.range,
          selectionTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          startRangeSelectionColor: Color(constants.calendarColor),
          endRangeSelectionColor: Color(constants.calendarColor),
          rangeSelectionColor: Color(constants.calendarColor),
          rangeTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          selectionRadius: 50.0,
          todayHighlightColor: Color(constants.calendarColor),
          selectionShape: DateRangePickerSelectionShape.rectangle,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width/8, vertical: size.height/40),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                minimumSize: Size.fromHeight(35),
                primary: Color(constants.calendarColor),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                textStyle: TextStyle(fontSize: 15)
            ),
            onPressed:
                (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DietDayDetail(daysForDetail: presenter.getDays())),);
            },
            child: Text("Revisar plan Dietetico")),)
      ],
    );
  }
}
