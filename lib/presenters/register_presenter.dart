
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/preference.dart';
import 'package:full_feed_app/providers/preferences_provider.dart';
import 'package:provider/provider.dart';

class RegisterPresenter{
  var context;
  int desireRol = -1;
  List<Preference> meats = [];
  List<Preference> cereals = [];
  List<Preference> others = [];
  String userName = "";
  String firstName = "";
  String lastName = "";
  double height = 0.0;
  double weight = 0.0;
  double imc = 0.0;
  String dni = "";
  String email = "";
  String password = "";
  String rol = "";
  String sex = "";
  String birthDate = "";
  String phone = "";
  String registerDate = "";
  double abdominal = 0.0;
  double arm = 0.0;
  double tmb = 0.0;

  RegisterPresenter(BuildContext _context){
    context = _context;
    setPreferencesLists();
  }

  setImc(){
    imc = weight/pow(height, 2);
  }

  setDesireRol(int _desireRol){
    desireRol = _desireRol;
  }

  setPreferencesLists(){
    Provider.of<PreferenceProvider>(context, listen: false).listAllPreferences().then((value){
      categorizeLists(value);
    });
  }

  categorizeLists(List<Preference> originalList){
    for(int i = 0; i < originalList.length; i++){
      if(originalList[i].category!.categoryId == 4){
        cereals.add(originalList[i]);
      }
      if(originalList[i].category!.categoryId == 14){
        meats.add(originalList[i]);
      }
      if(originalList[i].category!.categoryId == 54){
        others.add(originalList[i]);
      }
    }
  }

}