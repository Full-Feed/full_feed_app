import 'package:flutter/material.dart';
import 'package:full_feed_app/screens/pages/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(35.0)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFF295D),
                      Color(0xffFFC3E9),
                    ],
                    stops: [0.01, 1],
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 200),
                          reverseDuration: const Duration(milliseconds: 200),
                          type: PageTransitionType.rightToLeft,
                          child: HomeScreen()
                      )
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text('Iniciar Sesión',
                    style: GoogleFonts.raleway()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
