import 'package:flutter/material.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/screens/pages/register/bmi_screen.dart';
import 'package:full_feed_app/screens/pages/register/loading_screen.dart';
import 'package:full_feed_app/screens/pages/register/register_form_screen.dart';
import 'package:full_feed_app/screens/pages/register/select_doctor.dart';
import 'package:full_feed_app/screens/pages/register/user_allergies_screen.dart';
import 'package:full_feed_app/screens/pages/register/user_likes_screen.dart';
import 'package:full_feed_app/screens/pages/register/user_register_form_screen.dart';
import 'package:full_feed_app/screens/pages/register/user_role_screen.dart';
import 'package:full_feed_app/screens/pages/register/welcome_screen.dart';
import 'package:full_feed_app/screens/widgets/authentication/register_steps_body.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      home: const RegisterUserForm(),
    );
  }
}

class RegisterUserForm extends StatefulWidget {
  const RegisterUserForm({Key? key}) : super(key: key);

  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}


class _RegisterUserFormState extends State<RegisterUserForm> {



  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).initRegisterPresenter(context);
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<UserProvider>(context, listen: false).registerPresenter.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: Provider.of<UserProvider>(context, listen: false).registerPresenter.pageController,
        children: [
          RegisterStepBody(
              title: 'Selecciona un rol',
              child: UserRoleScreen(),
              fabOnPressed: (){Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userInfo);},
              arrowBackOnPressed: () {Navigator.of(context, rootNavigator: true).pop();}
          ),
          RegisterStepBody(
              title: 'Datos personales',
              child: UserRegisterFormScreen(),
              fabOnPressed: () {
                  bool isValid = Provider.of<UserProvider>(context, listen: false).registerPresenter.validateUserFormKey();
                  if(isValid){
                    Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userRolForm);
                  }
                },
              arrowBackOnPressed: (){Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.role);}
          ),
          RegisterStepBody(
              title: 'Datos personales',
              child: RolRegisterFormScreen(),
              fabOnPressed: () {
                bool isValid = Provider.of<UserProvider>(context, listen: false).registerPresenter.validateRolFormKey();
                if(isValid){
                  if(Provider.of<UserProvider>(context, listen: false).registerPresenter.desireRol == 2){
                    Provider.of<UserProvider>(context, listen: false).registerPresenter.setDoctorRegisterDto();
                    Provider.of<UserProvider>(context, listen: false).doctorRegister(Provider.of<UserProvider>(context, listen: false).registerPresenter.doctorRegisterDto).then((value){
                      if(value){
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                duration: const Duration(milliseconds: 200),
                                reverseDuration: const Duration(milliseconds: 200),
                                type: PageTransitionType.leftToRight,
                                child: const WelcomeScreen()
                            )
                        );
                      }
                    });
                  }else{
                    Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userBMI);
                  }
                }
              },
              arrowBackOnPressed: (){Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userInfo);}
          ),
          RegisterStepBody(
              title: 'Índice de Masa Corporal',
              child: BMIScreen(),
              fabOnPressed: () {
                Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.selectDoctor);
                },
              arrowBackOnPressed: (){Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userRolForm);}
          ),
          RegisterStepBody(
              title: 'Seleccione un doctor',
              child: SelectDoctorScreen(),
              fabOnPressed: () {
                Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userLikes);
              },
              arrowBackOnPressed: (){Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userBMI);}
          ),
          RegisterStepBody(
              title: 'Comidas que te gustan',
              child: UserLikesScreen(type: "FAVORITE"),
              fabOnPressed: () {
                Provider.of<UserProvider>(context, listen: false).registerPreferences(Provider.of<UserProvider>(context, listen: false).registerPresenter.preferencesFavorite).then((value){
                  if(value){
                    Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userFoodAllergies);
                  }
                });
              },
              arrowBackOnPressed: (){Navigator.of(context, rootNavigator: true).pop();}
          ),
          RegisterStepBody(
              title: 'Alergias',
              child: UserAllergiesScreen(type: "ALLERGY",),
              fabOnPressed: () {
                if(Provider.of<UserProvider>(context, listen: false).registerPresenter.preferencesAllergy.isNotEmpty){
                  Provider.of<UserProvider>(context, listen: false).registerPreferences(Provider.of<UserProvider>(context, listen: false).registerPresenter.preferencesAllergy).whenComplete((){
                    Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.waitForDiet);
                  });
                }
                else{
                  Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.waitForDiet);
                }
              },
              arrowBackOnPressed: (){Navigator.of(context, rootNavigator: true).pop();}
          ),
          RegisterStepBody(
              title: 'Dieta',
              child: LoadingScreen(text: "Tu plan nutricional se esta generando...", register: true),
              fabOnPressed: () {},
              arrowBackOnPressed: (){}
          ),
        ],
      ),
    );
  }
}