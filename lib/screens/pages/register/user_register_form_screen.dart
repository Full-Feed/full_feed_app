import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserRegisterFormScreen extends StatefulWidget {
  RegisterPresenter presenter;
  UserRegisterFormScreen({Key? key, required this.presenter}) : super(key: key);

  @override
  UserRegisterFormScreenState createState() => UserRegisterFormScreenState();
}

class UserRegisterFormScreenState extends State<UserRegisterFormScreen> with
    AutomaticKeepAliveClientMixin{

  File? image;
  final constants = Constants();
  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;

  void _togglePassword() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
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
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Flexible(
            child: ListView(
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 160, maxWidth: 140),
                  margin: const EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 1.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFF295D),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                          child: Image.file(
                            image!,
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                            height: 130,
                            width: 130,
                            child: const Center(
                                child: Icon(Icons.account_circle,
                                    size: 50.0, color: Colors.black38))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Añadir Foto',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.white)),
                              const SizedBox(width: 5.0),
                              InkWell(
                                child: const Icon(Icons.add_a_photo_rounded,
                                    size: 14.0, color: Colors.white),
                                onTap: () async {
                                  pickImage(ImageSource.gallery);
                                },
                              ),
                            ])
                      ]),
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
                      onChanged: (value){
                        setState(() {
                          widget.presenter.firstName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Nombres',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese un nombre";
                        }
                      },
                    ),
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
                      onChanged: (value){
                        setState(() {
                          widget.presenter.lastName = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Apellidos',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          )),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese un apellido";
                        }
                      },
                    ),
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
                      onChanged: (value){
                        setState(() {
                          widget.presenter.phone = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Teléfono',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          )),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese un teléfono";
                        }
                      },
                    ),
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
                      onChanged: (value){
                        setState(() {
                          widget.presenter.email = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Correo',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))),),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese un correo";
                        }
                        if (!value.contains("@")) {
                          return "Ingrese un correo valido";
                        }
                      },
                    ),
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
                      onChanged: (value){
                        setState(() {
                          widget.presenter.password = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Contraseña',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30.0))),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(bottom: size.height/80),
                            child: InkWell(
                              child: isHiddenPassword == true
                                  ? const Icon(Icons.visibility, size: 20, color: Colors.redAccent,)
                                  : const Icon(Icons.visibility_off, size: 20, color: Colors.redAccent,),
                              onTap: _togglePassword,
                            ),
                          )),
                      obscureText: isHiddenPassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingrese una contraseña";
                        }
                      },
                    ),
                  ),
                ),
              ].map((children) =>
                  Padding(padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: children)).toList(),
            ),
          ),
        )
      ],
    );
  }
}