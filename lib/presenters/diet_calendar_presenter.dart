import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DietCalendarPresenter {
  void onButtonClicked(String user, String password) {}
}

class BasicDietCalendarPresenter implements DietCalendarPresenter {
  var context;
  List<DateTime> daysForDetail = [];
  DateTime initial = DateTime.now();
  DateTime last = DateTime.now();
  int dietFirstDay = DateTime.tuesday;
  late DateRangePickerController controller;

  BasicDietCalendarPresenter(BuildContext _context, DateRangePickerController _controller) {
    context = _context;
    controller = _controller;
  }

  @override
  void onButtonClicked(String user, String password) {

  }

  bool isSameDate(dynamic date1, dynamic date2) {
    if (date2 == date1) {
      return true;
    }

    if (date1 == null || date2 == null) {
      return false;
    }

    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  getDays(){
    daysForDetail.clear();
    for(int i = 0; i < 7; i ++){
      daysForDetail.add(initial.add(Duration(days: i)));
    }
    return daysForDetail;
  }

  getWeek(DateRangePickerSelectionChangedArgs args){
    int firstDayOfWeek = dietFirstDay % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0? 7 + endDayOfWeek : endDayOfWeek;
    PickerDateRange ranges = args.value;
    DateTime date1 = (ranges.endDate ?? ranges.startDate)!;
    DateTime date2 = (ranges.endDate?? ranges.startDate)!;
    if(date1.isAfter(date2))
    {
      var date=date1;
      date1=date2;
      date2=date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    int toAdd1;
    int toAdd2;

    if(date1.weekday < firstDayOfWeek || date1.weekday == 7){
      toAdd2 = endDayOfWeek - day2;
      toAdd1 = -1 * (6 - toAdd2.abs());
    }
    else{
      toAdd1 = firstDayOfWeek - day1;
      toAdd2 = 6 - toAdd1.abs();
    }
    DateTime dat1 = date1.add(Duration(days: toAdd1));
    DateTime dat2 = date2.add(Duration(days: toAdd2));

    if(ranges.endDate == null){
      if(date1.weekday == firstDayOfWeek){
        controller.selectedRange = PickerDateRange(dat1, dat2);
      }
      else{
        if(!isSameDate(dat1, ranges.startDate))
        {
          controller.selectedRange = PickerDateRange(dat1, dat2);
        }
      }

      initial = dat1;
      last = dat2;

    }
  }

  setCalendar(){

    int firstDayOfWeek = dietFirstDay % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0? 7 + endDayOfWeek : endDayOfWeek;
    DateTime date1 = DateTime.now();
    DateTime date2 = DateTime.now();
    if(date1.isAfter(date2))
    {
      var date=date1;
      date1=date2;
      date2=date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    int toAdd1;
    int toAdd2;


    if(date1.weekday < firstDayOfWeek || date1.weekday == 7){
      toAdd2 = endDayOfWeek - day2;
      toAdd1 = -1 * (6 - toAdd2.abs());
    }
    else{
      toAdd1 = firstDayOfWeek - day1;
      toAdd2 = 6 - toAdd1.abs();
    }

    DateTime dat1 = date1.add(Duration(days: toAdd1));
    DateTime dat2 = date2.add(Duration(days: toAdd2));

    controller.selectedRange = PickerDateRange(dat1, dat2);

    initial = dat1;
    last = dat2;
  }


}