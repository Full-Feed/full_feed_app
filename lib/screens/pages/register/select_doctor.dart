import 'dart:math';

import 'package:flutter/material.dart';
import 'package:full_feed_app/models/entities/doctor.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/screens/widgets/authentication/dropdown.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class Option{
  int id;
  String name;

  Option(this.id, this.name);

}

class SelectDoctorScreen extends StatefulWidget {

  SelectDoctorScreen({Key? key}) : super(key: key);

  @override
  SelectDoctorScreenState createState() => SelectDoctorScreenState();
}

class SelectDoctorScreenState extends State<SelectDoctorScreen>{

  final constants = Constants();
  late TextEditingController pinController;
  late var future;
  int cantError = 3;
  bool error = false;

  @override
  void initState() {
    pinController = TextEditingController();
    future = Provider.of<UserProvider>(context, listen: false).getDoctors();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height/30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: ListView(
                children: [
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
                      padding: EdgeInsets.only(top: 0),
                      child: FutureBuilder<List<Doctor>>(
                        future: future,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            if(snapshot.data!.isNotEmpty){
                              return DropDown(hintText: "Doctor", datos: snapshot.data!.map<DropdownMenuItem<Doctor>>((Doctor item){
                                return DropdownMenuItem<Doctor>(
                                  child: Text(item.user!.firstName.toString()),
                                  value: item,
                                );
                              }).toList(), initialValue: snapshot.data![0].doctorId);
                            }
                            else{
                              return Text("No hay doctores");
                            }
                          }
                          else{
                            return Text("Cargando doctores");
                          }
                        },
                      )
                    ),
                  ),
                  Text("Ingrese el codigo generado por el doctor"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width/10),
                    child: PinCodeTextField(
                      length: 5,

                      appContext: context,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        activeColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        selectedColor: Color(constants.primaryColor),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 45,
                        fieldWidth: 40,

                      ),
                      animationDuration: Duration(milliseconds: 300),
                      controller: pinController,
                      onCompleted: (v) {
                        Provider.of<UserProvider>(context, listen: false).validateAccessCode().then((value){
                          if(value){
                            Provider.of<UserProvider>(context, listen: false).registerPresenter.setPatientRegisterDto();
                            Provider.of<UserProvider>(context, listen: false).registerPresenter.switchPage(GoToPage.userLikes);
                          }
                          else{
                            setState(() {
                              error = true;
                              cantError--;
                            });
                            pinController.clear();
                          }
                        });
                      },
                      onChanged: (value) {
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.accessCode = value;
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                  Visibility(
                    visible: error,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("El codigo no coincide con el doctor"),
                        Text("${cantError} intentos restantes")
                      ],
                    ),
                  )
                ].map((children) =>
                    Padding(padding: const EdgeInsets.fromLTRB(20, 15, 20,15),
                        child: children)).toList(),
              ),
            ),
        ],
      ),);
  }
}
