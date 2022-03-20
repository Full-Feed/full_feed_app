import 'package:flutter/material.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/authentication/forgot_password_button.dart';
import 'package:full_feed_app/screens/widgets/authentication/login_button.dart';
import 'package:full_feed_app/screens/widgets/authentication/register_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';


class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  final constants = Constants();
  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;

  void _togglePassword() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Color(constants.primaryColor),
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: size.height*0.15,
                child: Image.asset(
                    'assets/fullfeedwhite.png',
                    height: 150, width: 150,
                    fit: BoxFit.fill
                )
            ),
            Positioned(
              top: size.height*0.45, bottom: 10, left: 10, right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: ListView(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: size.width/30, bottom: size.height/80),
                            child: Text('Usuario', style: TextStyle(color: Color(0XFF7B7B7B)),),),
                            Container(
                              height: size.height/20,
                              decoration: BoxDecoration(
                                  color: Color(0XFFFAFAFA),
                                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: size.height/80),
                                child: TextFormField(
                                  initialValue: 'siempreut@hotmail.com',
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: 'example@example.com',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value){
                                    Provider.of<UserProvider>(context, listen: false).setEmail(value!);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Ingrese un correo";
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.only(left: size.width/30, bottom: size.height/80),
                              child: Text('Contraseña', style: TextStyle(color: Color(0XFF7B7B7B)),),),
                            Container(
                              height: size.height/20,
                              decoration: BoxDecoration(
                                  color: Color(0XFFFAFAFA),
                                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                initialValue: 'string',
                                onSaved: (value){
                                  Provider.of<UserProvider>(context, listen: false).setPassword(value!);
                                },
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                    suffixIcon: InkWell(
                                      child: isHiddenPassword == true
                                          ? Icon(Icons.visibility, size: 20, color: Color(constants.primaryColor),)
                                          : Icon(Icons.visibility_off, size: 20, color: Color(constants.primaryColor),),
                                      onTap: _togglePassword,
                                    )
                                ),
                                obscureText: isHiddenPassword,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Ingrese una contraseña";
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width/20),
                              child: LoginButton(press: (){
                                final isValid = _formKey.currentState!.validate();
                                if (isValid) {
                                  _formKey.currentState!.save();
                                  Provider.of<UserProvider>(context, listen: false).userLogin().then((value){
                                    if(value){
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
                                  });
                                }
                              },),),
                            ForgotPasswordButton(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width/20, vertical: size.height/80),
                              child: RegisterButton(),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}