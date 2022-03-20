import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/utilities/constants.dart';

class RegisterStepBody extends StatefulWidget {
  final String title;
  final Widget child;
  final VoidCallback fabOnPressed;
  final VoidCallback arrowBackOnPressed;
  const RegisterStepBody({required this.fabOnPressed, required this.arrowBackOnPressed,
    required this.title, required this.child, Key? key}) : super(key: key);

  @override
  _RegisterStepBodyState createState() => _RegisterStepBodyState();
}

class _RegisterStepBodyState extends State<RegisterStepBody> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final constants = Constants();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(constants.primaryColor),
        leading: Padding(
          padding: EdgeInsets.only(top: size.height/40, left: size.width/30),
          child: IconButton(onPressed: widget.arrowBackOnPressed,
              icon: Icon(Icons.arrow_back_ios)),
        ),
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: size.height/35),
          child: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 16)),
        ),

      ),
      backgroundColor: Color(constants.primaryColor),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(10.0),
        child: widget.child,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: widget.fabOnPressed,
          elevation: 2,
          child: Ink(
            width: 200,
            height: 200,
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                gradient: LinearGradient(
                    colors: [Color(constants.primaryColor), Color(0xFFFF9FC8)],
                    stops: [0.05, 1]
                )
            ),
            child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 25),
          ),
        ),
      ),
    );
  }
}