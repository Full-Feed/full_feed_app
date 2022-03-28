
import 'package:full_feed_app/models/entities/patient.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../widgets/diet_schedule/message.dart';
import 'diet_day_detail.dart';

class DietCalendarPage extends StatefulWidget {

  Patient? patient;
  DietCalendarPage({Key? key, this.patient}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DietCalendarPageState();

}

class DietCalendarPageState extends State<DietCalendarPage> {
  final constants = Constants();

  @override
  void initState() {
    if(UserSession().rol == 'p'){
      Provider.of<DietProvider>(context, listen: false).initDietPresenter(context, null);
    }
    else{
      Provider.of<DietProvider>(context, listen: false).initDietPresenter(context, widget.patient!);
    }
    Provider.of<DietProvider>(context, listen: false).dietPresenter.setCalendar();
    super.initState();
  }

  _showDialog(){
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (BuildContext context) {
        return Message(text: UserSession().rol == "p" ? 'En esa semana no tiene dietas' : 'El paciente no tiene dietas esa semana', yesFunction: (){
          Navigator.pop(context);
        }, noFunction: (){}, options: false,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SfDateRangePicker(
          controller: Provider.of<DietProvider>(context, listen: false).dietPresenter.controller,
          onSelectionChanged: Provider.of<DietProvider>(context, listen: false).dietPresenter.getWeek,
          showNavigationArrow: false,
          headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold, fontSize: 18)),
          view: DateRangePickerView.month,
          monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: UserSession().rol == 'p' ? UserSession().firstDayOfWeek : widget.patient!.firstDayOfWeek!, numberOfWeeksInView: 6, showTrailingAndLeadingDates: true, enableSwipeSelection: false),
          selectionMode: DateRangePickerSelectionMode.range,
          selectionTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          startRangeSelectionColor: Color(constants.primaryColor),
          endRangeSelectionColor: Color(constants.primaryColor),
          rangeSelectionColor: Color(constants.primaryColor),
          rangeTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          selectionRadius: 50.0,
          todayHighlightColor: Color(constants.primaryColor),
          selectionShape: DateRangePickerSelectionShape.rectangle,
        ),
        Padding(
            padding: EdgeInsets.only(top: size.height/10),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(constants.primaryColor), Color(0xFFFE7EB4)],
                      stops: [0.05, 1]
                  )
              ),
              child: ElevatedButton(
                onPressed: () async {
                  Provider.of<DietProvider>(context, listen: false).dietPresenter.getDays();
                  if(UserSession().rol == 'p'){
                    await Provider.of<DietProvider>(context, listen: false).getWeekDietMeals().then((value){
                      if(value && Provider.of<DietProvider>(context, listen: false).dietPresenter.weekMealList.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DietDayDetail(register: false,)),);
                      }
                      else{
                        _showDialog();
                      }
                    });
                  }
                  else{
                    await Provider.of<DietProvider>(context, listen: false).getWeekDietMealsByPatient(Provider.of<DietProvider>(context, listen: false).dietPresenter.patient.patientId!).then((value){
                      if(value && Provider.of<DietProvider>(context, listen: false).dietPresenter.weekMealList.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DietDayDetail(register: false,)),);
                      }
                      else{
                        _showDialog();
                      }
                    });
                  }
                },
                child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: size.height/20,),
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
        )
      ],
    );
  }
}
