
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/dtos/patient_register.dart';
import 'package:full_feed_app/models/entities/patient.dart';
import 'package:full_feed_app/utilities/connection_tags.dart';

class UserProvider with ChangeNotifier {

  final connectionTags = ConnectionTags();

  Future<Patient> patientRegister(PatientRegisterDto newPatient) async{

    Patient patient = Patient();

    var body = jsonEncode({
      'username' : newPatient.username,
      'firstName' : newPatient.firstName,
      'lastName' : newPatient.lastName,
      'dni' : newPatient.dni,
      'email' : newPatient.email,
      'password' : newPatient.password,
      'rol' : newPatient.rol,
      'sex' : newPatient.sex,
      'birthDate' : newPatient.birthDate,
      'phone' : newPatient.phone,
      'registerDate' : newPatient.registerDate,
      'abdominal' : newPatient.abdominal,
      'arm' : newPatient.arm,
      'imc' : newPatient.imc,
      'tmb' : newPatient.tmb,
      'height' : newPatient.height,
      'weight' : newPatient.weight,
    });

    final api = connectionTags.baseUrl + connectionTags.userEndpoint + connectionTags.patientRegister;

    final dio = Dio();
    Response response;
    response = await dio.post(api, data: body);
    if(response.statusCode == 200){
      patient = Patient.fromJson(response.data["data"]);
    }

    return patient;
  }

}