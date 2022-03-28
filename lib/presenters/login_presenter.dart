import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/entities/user_session.dart';
import '../providers/diet_provider.dart';
import '../providers/user_provider.dart';
import '../screens/pages/home/home_screen.dart';

class LoginPresenter{

  late var context;

  LoginPresenter(BuildContext _context){
    context = _context;
  }

  doLogin() {
    Provider.of<UserProvider>(context, listen: false).userLogin().then((value){
      if(value == 0){
        Provider.of<DietProvider>(context, listen: false).initHomePresenter(context);
        if(UserSession().rol == 'p'){
          Provider.of<UserProvider>(context, listen: false).getDoctorByPatient(context).then((resp){
            if(resp) {
              Provider.of<UserProvider>(context, listen: false).getUserSuccessfulDays().then((response){
                if(response){
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 200),
                          reverseDuration: const Duration(milliseconds: 200),
                          type: PageTransitionType.rightToLeft,
                          child: HomeScreen()
                      )
                  );
                }
              });
            }
          });
        }
        else {
          Provider.of<UserProvider>(context, listen: false).getPatientsByDoctor(context).then((response){
            if(response){
              Navigator.push(
                  context,
                  PageTransition(
                      duration: const Duration(milliseconds: 200),
                      reverseDuration: const Duration(milliseconds: 200),
                      type: PageTransitionType.rightToLeft,
                      child: HomeScreen()
                  )
              );
            }
          });
        }
      }
      else{
        switch(value){
          case 1:
            Navigator.pop(context);
            break;
          case 2:
            Navigator.pop(context);
            break;
        }
      }
    });
  }
}