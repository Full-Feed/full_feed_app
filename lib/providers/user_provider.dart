
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/dtos/patient_register.dart';
import 'package:full_feed_app/models/dtos/preference_register.dart';
import 'package:full_feed_app/models/entities/doctor.dart';
import 'package:full_feed_app/models/entities/patient.dart';
import 'package:full_feed_app/models/entities/region.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/models/entities/weight_history.dart';
import 'package:full_feed_app/presenters/chat_presenter.dart';
import 'package:full_feed_app/presenters/profile_presenter.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/utilities/connection_tags.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/dtos/doctor_register.dart';
import '../models/entities/nutrition_stat.dart';
import '../models/entities/preference.dart';
import '../presenters/register_presenter.dart';

class UserProvider with ChangeNotifier {

  final connectionTags = ConnectionTags();
  late RegisterPresenter registerPresenter;
  late ProfilePresenter profilePresenter;
  late ChatPresenter chatPresenter;
  String email = "";
  String password = "";

  initRegisterPresenter(BuildContext _context){
    registerPresenter = RegisterPresenter(_context);
  }

  initChatPresenter(BuildContext _context){
    chatPresenter = ChatPresenter(_context);
  }

  initProfilePresenter(BuildContext _context){
    profilePresenter = ProfilePresenter(_context);
  }

  setMessages(bool _ready){
    chatPresenter.messagesReady = _ready;
    notifyListeners();
  }

  setEmail(String _email){
    email = _email;
  }

  setPassword(String _password){
    password = _password;
  }

  Future<bool> registerAndLogin() async{
    await patientRegister(registerPresenter.patientRegisterDto).then((value) {
      userLogin();
    });
    return true;
  }

  Future<bool> userLogin() async{

    final api = connectionTags.baseUrl + connectionTags.userEndpoint + connectionTags.userLogin;

    var body = jsonEncode({
      'email' : email,
      'password' : password,
    });

    final dio = Dio();
    Response response;
    response = await dio.post(api, data: body);

    if(response.statusCode == 200 && response.data['data'] != null){
      UserSession().create(response.data["data"]["profile"]["user"]["userId"], response.data["data"]["profile"]["user"]["username"], response.data["data"]["profile"]["user"]["firstName"],
          response.data["data"]["profile"]["user"]["lastName"], response.headers.value("Token")!, response.data["data"]["profile"]["user"]["rol"], int.parse(response.headers.value("Firstdayofweek")!),
          response.headers.value("Date")!);
      if(UserSession().rol == "p"){
        UserSession().setProfileId(response.data["data"]["profile"]["patientId"]);
      }
      else{
        UserSession().setProfileId(response.data["data"]["profile"]["doctorId"]);
        UserSession().setActivePatients(response.data["data"]["profile"]["activePatients"]);
      }
      return true;
    }

    return false;
  }

  Future<bool> getUserSuccessfulDays() async{
    final api = connectionTags.baseUrl + connectionTags.patientEndpoint + connectionTags.successfulDays;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.get(api, queryParameters: {'patientId' : UserSession().profileId});
    if(response.statusCode == 200){
      UserSession().setSuccessfulDays(response.data['data']['successfulDays']);
      UserSession().lossWeight = response.data['data']['lostWeight'];
      return true;
    }
    return false;
  }

  Future<bool> getConsumedBalance() async{
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime endDate = DateTime.now(); //.subtract(Duration(days: 1))
    DateTime startDate = endDate.subtract(Duration(days: 6));

    final api = connectionTags.baseUrl + connectionTags.nutritionalPlanEndpoint + connectionTags.consumedBalance;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.get(api, queryParameters: {'endDate' : dateFormat.format(endDate), 'startDate' : dateFormat.format(startDate), 'patientId' : UserSession().profileId});
    if(response.statusCode == 200){
      List aux = response.data['data'].map((e) => NutritionStat.fromJson(e)).toList();
      profilePresenter.nutritionStats = aux.cast<NutritionStat>();
      profilePresenter.generateNutritionStats();
      return true;
    }
    return false;
  }

  Future<bool> getWeightEvolution() async{
    final api = connectionTags.baseUrl + connectionTags.nutritionalPlanEndpoint + connectionTags.weightEvolution;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.get(api, queryParameters: {'patientId' : UserSession().profileId});
    if(response.statusCode == 200){
      List aux = response.data['data'].map((e) => WeightHistory.fromJson(e)).toList();
      profilePresenter.weightHistory = aux.cast<WeightHistory>();
      profilePresenter.generateWeightHistory();
      return true;
    }
    return false;
  }


  Future<bool> patientRegister(PatientRegisterDto newPatient) async{

    var body = {
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
      'regionId' : newPatient.regionId,
      'abdominal' : newPatient.abdominal,
      'arm' : newPatient.arm,
      'imc' : newPatient.imc,
      'tmb' : newPatient.tmb,
      'height' : newPatient.height,
      'weight' : newPatient.weight,
    };

    final api = connectionTags.baseUrl + connectionTags.userEndpoint + connectionTags.patientRegister;

    final dio = Dio();
    Response response;
    response = await dio.post(api, data: jsonEncode(body));
    if(response.statusCode == 201){
      email = newPatient.email;
      password = newPatient.password;
      return true;
    }
    return false;
  }

  Future<bool> doctorRegister(DoctorRegisterDto newDoctor) async{

    var body = {
      'username' : newDoctor.username,
      'firstName' : newDoctor.firstName,
      'lastName' : newDoctor.lastName,
      'dni' : newDoctor.dni,
      'email' : newDoctor.email,
      'password' : newDoctor.password,
      'rol' : newDoctor.rol,
      'sex' : newDoctor.sex,
      'birthDate' : newDoctor.birthDate,
      'phone' : newDoctor.phone,
      'licenseNumber' : newDoctor.licenseNumber,
    };

    final api = connectionTags.baseUrl + connectionTags.userEndpoint + connectionTags.doctorRegister;

    final dio = Dio();
    Response response;
    response = await dio.post(api, data: jsonEncode(body));
    if(response.statusCode == 201){
      email = newDoctor.email;
      password = newDoctor.password;
      return true;
    }
    return false;
  }

  Future<bool> getAllRegions() async{

    final api = connectionTags.baseUrl + connectionTags.regionEndpoint + connectionTags.allRegion;

    final dio = Dio();
    Response response;
    response = await dio.get(api);
    if(response.statusCode == 200){
      List aux = response.data['data'].map((e) => Region.fromJson(e)).toList();
      registerPresenter.regionList = aux.cast<Region>();
    }
    return false;
  }

  Future<bool> getPatientsByDoctor(BuildContext context) async{
    final api = connectionTags.baseUrl + connectionTags.doctorEndpoint + connectionTags.getPatientsByDoctor;

    final dio = Dio();
    Response response;
    response = await dio.get(api, queryParameters: {'doctorId' : UserSession().profileId});
    if(response.statusCode == 200){
      List aux = response.data['data'].map((e) => Patient.fromJson(e)).toList();
      Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor = aux.cast<Patient>();
      return true;
    }
    return false;
  }

  Future<bool> getDoctorByPatient(BuildContext context) async{
    final api = connectionTags.baseUrl + connectionTags.patientEndpoint + connectionTags.getDoctor;

    final dio = Dio();
    Response response;
    response = await dio.get(api, queryParameters: {'patientId' : UserSession().profileId});
    if(response.statusCode == 200){
      Doctor aux = Doctor.fromJson(response.data['data']);
      Provider.of<DietProvider>(context, listen: false).homePresenter.doctorByPatient = aux;
      return true;
    }
    return false;
  }

  Future<bool> registerPreferences(List<PreferenceRegisterDto> preferences) async{
    final api = connectionTags.baseUrl + connectionTags.patientEndpoint + connectionTags.preferencesEndpoint;
    final dio = Dio();
    Response response;
    response = await dio.post(api, queryParameters: {'patientId' : UserSession().profileId}, data: jsonEncode(preferences));
    if(response.statusCode == 201){
      return true;
    }
    return false;
  }

  Future<List<Doctor>> getDoctors() async{
    final api = connectionTags.baseUrl + connectionTags.doctorEndpoint;
    final dio = Dio();
    Response response;
    response = await dio.get(api);
    if(response.statusCode == 200){
      List aux = response.data['data'].map((e) => Doctor.fromJson(e)).toList();
      return aux.cast<Doctor>();
    }
    return [];
  }


  Future<String> generateAccessCode() async{
    final api = connectionTags.baseUrl + connectionTags.doctorEndpoint + connectionTags.generateAccessCode;
    final dio = Dio();
    Response response;
    response = await dio.get(api, queryParameters: {'doctorId' : UserSession().profileId});
    if(response.statusCode == 200){
      return response.data['data'];
    }
    return "";
  }

  Future<bool> validateAccessCode() async{
    final api = connectionTags.baseUrl + connectionTags.patientEndpoint + connectionTags.validateAccessCode;
    final dio = Dio();
    Response response;
    response = await dio.get(api, queryParameters: {'accessCode' : registerPresenter.accessCode});
    if(response.statusCode == 200){
      return response.data['data'];
    }
    return false;
  }

  logOut(){
    UserSession().logOut();
    chatPresenter.client.disconnectUser();
  }

}