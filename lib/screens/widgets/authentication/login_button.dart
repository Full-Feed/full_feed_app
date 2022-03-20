import 'package:flutter/material.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/screens/pages/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';

class LoginButton extends StatefulWidget {

  VoidCallback press;
  LoginButton({Key? key, required this.press}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  final constants = Constants();

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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(constants.primaryColor),
                      Color(0xffFFC3E9),
                    ],
                    stops: [0.40, 1],
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: widget.press,
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
