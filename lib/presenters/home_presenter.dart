import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/meal.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/entities/doctor.dart';
import '../models/entities/patient.dart';
import '../screens/pages/home/home_screen.dart';

class HomePresenter{

  List<Meal> dayMealList = [];
  List<Patient> patientsByDoctor = [];
  Doctor doctorByPatient = Doctor();
  List<List<Meal>> patientsDayMeals = [];
  bool mealsReady = false;

  var context;
  HomePresenter(BuildContext _context){
    context = _context;
  }


  String setFoodDayName(String originalName){
    switch(originalName){
      case "DESAYUNO":
        return "Desayuno";
      case "ALMUERZO":
        return "Almuerzo";
      case "CENA":
        return "Cena";
      case "MERIENDA_DIA":
        return "Merienda Dia";
      case "MERIENDA_TARDE":
        return "Merienda Tarde";
      default:
        return "";
    }
  }

  setPatientAfterUpdate(Patient patient){
    for(int i = 0; i < patientsByDoctor.length; i++){
      if(patientsByDoctor[i].patientId == patient.patientId){
        patientsByDoctor[i] = patient;
      }
    }
  }

  Patient getPatientAt(int _patientId){
    return patientsByDoctor.where((element) => element.patientId == _patientId).first;
  }

  getPatientMeals() async{
    int aux = 0;
    patientsDayMeals = List.filled(patientsByDoctor.length, []);
    if(patientsByDoctor.isEmpty){
      Provider.of<DietProvider>(context, listen: false).setMealsReady(true);
    }
    for(int i = 0; i < patientsByDoctor.length; i++){
      Provider.of<DietProvider>(context, listen: false).getDayMealsByPatient(patientsByDoctor[i].patientId!).then((value){
        patientsDayMeals[patientsByDoctor.indexOf(patientsByDoctor[i])] = value;
        aux++;
        if(aux == patientsByDoctor.length){
          Provider.of<DietProvider>(context, listen: false).setMealsReady(true);
        }
      });
    }
  }

}