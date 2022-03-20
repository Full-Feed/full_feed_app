import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/models/entities/patient.dart';

import '../../../utilities/constants.dart';

class DoctorPatient extends StatefulWidget {
  String title;
  Patient patient;
  DoctorPatient({Key? key, required this.title, required this.patient}) : super(key: key);

  @override
  DoctorPatientState createState() => DoctorPatientState();
}

class DoctorPatientState extends State<DoctorPatient> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();
  bool isPressed = false;
  String state = "";
  Color colorState = Colors.white;

  @override
  bool get wantKeepAlive => true;


  setValue(double imc){
    if (imc >= 30.0) {
      setState(() {
        colorState = Color(0XFFFF003E);
        state = "OBESIDAD";
      });
    }
    if (imc < 30.0 && imc >= 25.0) {
      setState(() {
        colorState = Color(0XFFFF295D);
        state = "SOBREPESO";
      });
    }
    if (imc < 24.9 && imc >= 18.5) {
      setState(() {
        colorState = Color(0XFF02D871);
        state = "NORMAL";
      });
    }
    if (imc < 18.5) {
      setState(() {
        colorState = Color(0XFFFFEA29);
        state = "BAJO PESO";
      });
    }
  }
  @override
  void initState() {
    super.initState();
    setValue(widget.patient.imc!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height/10,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width/20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.grey
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width/30, vertical: size.height/50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.patient.user!.firstName.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: size.width/25),),
                    Text('Altura: ' + widget.patient.height.toString() + " m", style: TextStyle(color: Colors.grey, fontSize: size.width/35),),
                    Text('Altura: ' + widget.patient.weight.toString() + " kg", style: TextStyle(color: Colors.grey, fontSize: size.width/35),),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: size.width/6,
            width: size.width/6,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorState
            ),
            child: Center(
              child: Text(state, style: TextStyle(fontSize: 10, color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}