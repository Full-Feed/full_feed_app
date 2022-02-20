import 'package:flutter/material.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/screens/pages/home/home_screen.dart';
import 'package:full_feed_app/screens/pages/register/bmi_screen.dart';
import 'package:full_feed_app/screens/pages/register/register_form_screen.dart';
import 'package:full_feed_app/screens/pages/register/user_likes_screen.dart';
import 'package:full_feed_app/screens/pages/register/user_register_form_screen.dart';
import 'package:full_feed_app/screens/pages/register/user_role_screen.dart';
import 'package:full_feed_app/screens/widgets/authentication/register_steps_body.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';


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

class GoToPage {
  static const int role = 0;
  static const int userInfo = 1;
  static const int userRolForm = 2;
  static const int userBMI = 3;
  static const int userLikes = 4;
  static const int userFoodAllergies = 5;
}

class _RegisterUserFormState extends State<RegisterUserForm> {

  final PageController _pageController = PageController(initialPage: GoToPage.role);
  late RegisterPresenter presenter;

  void _switchPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear
    );
  }

  @override
  void initState() {
    presenter = RegisterPresenter(context);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          RegisterStepBody(
              title: 'Selecciona un rol',
              child: UserRoleScreen(presenter: presenter,),
              fabOnPressed: (){_switchPage(GoToPage.userInfo);},
              arrowBackOnPressed: () {Navigator.of(context, rootNavigator: true).pop();}
          ),
          RegisterStepBody(
              title: 'Datos personales',
              child: UserRegisterFormScreen(presenter: presenter,),
              fabOnPressed: () {_switchPage(GoToPage.userRolForm);},
              arrowBackOnPressed: (){_switchPage(GoToPage.role);}
          ),
          RegisterStepBody(
              title: 'Datos personales',
              child: RolRegisterFormScreen(presenter: presenter,),
              fabOnPressed: () {_switchPage(GoToPage.userBMI);},
              arrowBackOnPressed: (){_switchPage(GoToPage.userInfo);}
          ),
          RegisterStepBody(
              title: 'Índice de Masa Corporal',
              child: BMIScreen(presenter: presenter,),
              fabOnPressed: () {_switchPage(GoToPage.userLikes);},
              arrowBackOnPressed: (){_switchPage(GoToPage.userRolForm);}
          ),
          RegisterStepBody(
              title: 'Comidas que te gustan',
              child: UserLikesScreen(presenter: presenter,),
              fabOnPressed: () {_switchPage(GoToPage.userFoodAllergies);},
              arrowBackOnPressed: (){_switchPage(GoToPage.userBMI);}
          ),
          RegisterStepBody(
              title: 'Alergias',
              child: Text('hola'),
              fabOnPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        duration: const Duration(milliseconds: 200),
                        reverseDuration: const Duration(milliseconds: 200),
                        type: PageTransitionType.rightToLeft,
                        child: const HomeScreen()
                    )
                );
              },
              arrowBackOnPressed: (){_switchPage(GoToPage.userLikes);}
          ),
        ],
      ),
    );
  }
}