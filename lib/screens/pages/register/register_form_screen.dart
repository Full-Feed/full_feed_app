import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/screens/widgets/authentication/dropdown.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Option{

  int id;
  String name;

  Option(this.id, this.name);

}

class RolRegisterFormScreen extends StatefulWidget {
  RegisterPresenter presenter;

  RolRegisterFormScreen({Key? key, required this.presenter}) : super(key: key);

  @override
  RolRegisterFormScreenState createState() => RolRegisterFormScreenState();
}

class RolRegisterFormScreenState extends State<RolRegisterFormScreen> with
    AutomaticKeepAliveClientMixin{

  File? image;
  final constants = Constants();
  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  List<Option> sexList = [Option(1, "Femenino"), Option(2, "Masculino")];
  DateTime startDate = DateTime.now();
  TextEditingController birthDayController = TextEditingController();

  void _togglePassword() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              primaryColor: Colors.redAccent,
              colorScheme: const ColorScheme.light(
                  primary: Colors.redAccent),
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme
                      .primary), // This will change to light theme.
            ),
            child: child!,
          );
        },
        locale: Locale('en'),
        context: context,
        initialDate: startDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2025));
    if (picked != null && picked != startDate) {
      setState(() {
        birthDayController.text = DateFormat('dd/MM/yyy').format(picked);
      });
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final _temp = File(image.path);
      setState(() => this.image = _temp);
    } on PlatformException catch (error) {
      return null;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height/30),
    child: Column(
      children: [
        Form(
          key: _formKey,
          child: Flexible(
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
                    child: DropDown(hintText: "Sexo", datos: sexList.map<DropdownMenuItem<Option>>((Option item){
                      return DropdownMenuItem<Option>(
                        child: Text(item.name),
                        value: item,
                      );
                    }).toList(), initialValue: sexList[0].id),
                  ),
                ),
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
                      controller: birthDayController,
                      readOnly: true,
                      onTap: () => selectStartDate(context),
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Fecha de nacimiento',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)))),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Seleccione su fecha de nacimiento";
                        }
                      },
                    ),
                  ),
                ),
                widget.presenter.desireRol == 1 ? Container(
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
                        onChanged: (value){
                          setState(() {
                            widget.presenter.height = double.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: '1.80 m',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)))),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese su estatura";
                        }
                      },
                    ),
                  ),
                ) : Container(
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
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Código de nutricionista',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)))),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese código de nutricionista";
                        }
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.presenter.desireRol == 1 ? true : false,
                  child: Container(
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
                        onChanged: (value){
                          setState(() {
                            widget.presenter.weight = double.parse(value);
                          });
                        },
                          decoration: const InputDecoration(
                              hintText: 'Peso',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)))),
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese su peso ";
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ].map((children) =>
                  Padding(padding: const EdgeInsets.fromLTRB(20, 15, 20,15),
                      child: children)).toList(),
            ),
          ),
        )
      ],
    ),);
  }
}
