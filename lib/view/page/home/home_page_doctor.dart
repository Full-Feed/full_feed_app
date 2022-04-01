import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/util/colors.dart';
import 'package:full_feed_app/util/strings.dart';
import 'package:full_feed_app/view_model/chat_view_model.dart';
import 'package:full_feed_app/view_model/logged_in_view_model.dart';
import 'package:provider/provider.dart';

import '../../../model/entities/meal.dart';
import '../../../model/entities/patient.dart';
import '../../../model/entities/user_session.dart';
import '../../widget/home/chat_list_card.dart';
import '../../widget/home/home_doctor_diet_card.dart';

class HomePageDoctor extends StatefulWidget {
  final ChatViewModel chatViewModel;
  const HomePageDoctor({Key? key, required this.chatViewModel}) : super(key: key);

  @override
  HomePageDoctorState createState() => HomePageDoctorState();
}

class HomePageDoctorState extends State<HomePageDoctor> {


  @override
  void initState() {
    Provider.of<LoggedInViewModel>(context, listen: false).setHomePatientMeals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text("Home");
    // return Column(
    //   children: [
    //     Align(
    //       alignment: Alignment.topLeft,
    //       child: Text.rich(TextSpan(
    //           children: [
    //             const TextSpan(text: 'Bienvenido de nuevo, ', style: TextStyle(fontSize: 16)),
    //             TextSpan(text: UserSession().userFirstName.contains(" ")? UserSession().userFirstName.substring(0, UserSession().userFirstName.lastIndexOf(" ")) : UserSession().userFirstName,
    //                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    //           ])
    //       ),
    //     ),
    //     const SizedBox(height: 25.0),
    //     HomeDoctorDietCard(
    //       child: Provider.of<LoggedInViewModel>(context).getMealsReady() == false ?
    //       const Center(child: CircularProgressIndicator(),) :
    //       Provider.of<LoggedInViewModel>(context, listen: false).getPatientsByDoctor().isNotEmpty ?
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //           child: Column(
    //             children: [
    //               Padding(padding: EdgeInsets.symmetric(vertical: 5),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text('Paciente'),
    //                     Row(
    //                       children: List.generate(5, (index){
    //                         return SizedBox(
    //                           width: 35,
    //                           height: 35,
    //                           child: Padding(
    //                             padding: EdgeInsets.all(5),
    //                             child: Image.asset(breakfastImg, width: 5,
    //                                 height: 5, fit: BoxFit.contain),
    //                           )
    //                         );
    //                       }),
    //                     )
    //                   ],
    //                 ),),
    //               ListView.builder(
    //                   itemCount: 3,
    //                   itemBuilder: (BuildContext context, int index) {
    //
    //                     Patient _patient = Provider.of<LoggedInViewModel>(context, listen: false).getPatientsByDoctor()[index];
    //                     List<Meal> _patientMeals = Provider.of<LoggedInViewModel>(context).getPatientDayMeals()[index];
    //
    //                     return Padding(
    //                       padding: const EdgeInsets.symmetric(vertical: 2),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(_patient.user!.firstName.toString()),
    //                           _patientMeals.isNotEmpty ?
    //                           Row(
    //                             children: List.generate(5, (mealIndex){
    //                               return SizedBox(
    //                                 width: 35,
    //                                 height: 35,
    //                                 child: Checkbox(
    //                                     value: _patientMeals[mealIndex].status != 0,
    //                                     checkColor: selectedColor,
    //                                     fillColor: MaterialStateProperty.all(primaryColor),
    //                                     activeColor: primaryColor,
    //                                     shape: const CircleBorder(),
    //                                     onChanged: null),
    //                               );
    //                             }),
    //                           ) : Text('El paciente no tiene comidas hoy')
    //                         ],
    //                       ),);
    //                   },
    //               )
    //             ],
    //           ),) : SizedBox(
    //         height: 250,
    //         child: Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: const [
    //               Text('No tiene pacientes aún', style: TextStyle(color: Colors.grey)),
    //               Text('Disfrute de su dia con moderacion', style: TextStyle(color: Colors.grey)),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 25.0),
    //     ChatListCard(chatViewModel: widget.chatViewModel,)
    //   ],
    // );
  }
}