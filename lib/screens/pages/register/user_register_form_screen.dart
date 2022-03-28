import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class UserRegisterFormScreen extends StatefulWidget {
  UserRegisterFormScreen({Key? key}) : super(key: key);

  @override
  UserRegisterFormScreenState createState() => UserRegisterFormScreenState();
}

class UserRegisterFormScreenState extends State<UserRegisterFormScreen> with
    AutomaticKeepAliveClientMixin{

  File? image;
  final constants = Constants();
  bool isHiddenPassword = true;

  void _togglePassword() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).registerPresenter.userFormKey = GlobalKey(debugLabel: 'USER_REGISTER');
    super.initState();
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
          key: Provider.of<UserProvider>(context, listen: false).registerPresenter.userFormKey,
          child: Flexible(
            child: ListView(
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 160, maxWidth: 140),
                  margin: const EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 1.0),
                  decoration: BoxDecoration(
                      color: Color(constants.primaryColor),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 4),
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
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))),
                            height: 135,
                            width: 145,
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
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.firstName = value;
                      },
                      decoration: const InputDecoration(
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
                          Provider.of<UserProvider>(context, listen: false).registerPresenter.lastName = value;
                        },
                        decoration: const InputDecoration(
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese un apellido";
                          }
                        }
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
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          Provider.of<UserProvider>(context, listen: false).registerPresenter.dni = value;
                        },
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Dni',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            )),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese su dni";
                          }
                          if (value.length != 8) {
                            return "Ingrese un dni válido";
                          }
                        }
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
                        keyboardType: TextInputType.number,
                      onChanged: (value){
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.phone = value;
                      },
                      decoration: const InputDecoration(
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese su telefono";
                          }
                        }
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
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.email = value;
                      },
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Correo',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))),),
                      textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese su correo";
                          }
                        }
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
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.password = value;
                      },
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: 'Contraseña',
                          border: const OutlineInputBorder(
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingrese una contraseña";
                          }
                        }
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