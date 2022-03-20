import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/screens/widgets/home/chat_list_card.dart';
import 'package:full_feed_app/screens/widgets/home/home_doctor_diet_card.dart';
import 'package:provider/provider.dart';

import '../../../models/entities/user_session.dart';
import '../../../providers/diet_provider.dart';
import '../../../utilities/constants.dart';

class HomePageDoctor extends StatefulWidget {
  const HomePageDoctor({Key? key}) : super(key: key);

  @override
  HomePageDoctorState createState() => HomePageDoctorState();
}

class HomePageDoctorState extends State<HomePageDoctor> {
  final constants = Constants();
  var _future;

  @override
  void initState() {
    _future = Provider.of<DietProvider>(context, listen: false).homePresenter.getPatientMeals();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Bienvenido de nuevo, ', style: TextStyle(fontSize: 16)),
                TextSpan(text: UserSession().userFirstName.substring(0, UserSession().userFirstName.lastIndexOf(" ")), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ])
          ),
        ),
        const SizedBox(height: 25.0),
        HomeDoctorDietCard(
          child: Provider.of<DietProvider>(context).homePresenter.mealsReady == false ? Center(child: CircularProgressIndicator(),) :
        Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor.length > 0 ?
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Paciente'),
                      Row(
                        children: List.generate(5, (index){
                          return SizedBox(
                            width: 35,
                            height: 35,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(constants.breakfastImg, width: 5,
                                  height: 5, fit: BoxFit.contain),
                            )
                          );
                        }),
                      )
                    ],
                  ),),
                Column(
                    children: List.generate(Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor.length < 3 ?
                      Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor.length : 3, (index){
                      return Padding(padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor[index].user!.firstName.toString()),
                            Provider.of<DietProvider>(context).homePresenter.patientsDayMeals[index].isNotEmpty ?
                            Row(
                              children: List.generate(5, (i){
                                return SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Checkbox(
                                      value: Provider.of<DietProvider>(context, listen: false).homePresenter.patientsDayMeals[index][i].status == 0 ? false : true,
                                      checkColor: Color(constants.selectedColor),
                                      fillColor: MaterialStateProperty.all(Color(constants.primaryColor),),
                                      activeColor: Color(constants.primaryColor),
                                      shape: const CircleBorder(),
                                      onChanged: null),
                                );
                              }),
                            ) : Row(
                              children: List.generate(5, (i){
                                return SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Checkbox(
                                      value: false,
                                      checkColor: Color(constants.selectedColor),
                                      fillColor: MaterialStateProperty.all(Color(constants.primaryColor),),
                                      activeColor: Color(constants.primaryColor),
                                      shape: const CircleBorder(),
                                      onChanged: null),
                                );
                              }),
                            )
                          ],
                        ),);
                    })
                )
              ],
            ),) : SizedBox(
          height: 250,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No tiene pacientes aún', style: TextStyle(color: Colors.grey)),
                Text('Disfrute de su dia con moderacion', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        ),
        const SizedBox(height: 25.0),
        ChatListCard()
      ],
    );
  }
}