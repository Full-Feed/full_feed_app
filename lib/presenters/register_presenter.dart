
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/dtos/doctor_register.dart';
import 'package:full_feed_app/models/entities/preference.dart';
import 'package:full_feed_app/models/entities/region.dart';
import 'package:full_feed_app/providers/preferences_provider.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/dtos/patient_register.dart';
import '../models/dtos/preference_register.dart';
import '../models/entities/meal.dart';
import '../providers/diet_provider.dart';

class GoToPage {
  static const int role = 0;
  static const int userInfo = 1;
  static const int userRolForm = 2;
  static const int userBMI = 3;
  static const int selectDoctor = 4;
  static const int userLikes = 5;
  static const int userFoodAllergies = 6;
  static const int waitForDiet = 7;
}


class RegisterPresenter{

  var context;
  int desireRol = -1;

  List<Preference> meats = [];
  List<Preference> vegetables = [];
  List<Preference> seafood = [];
  List<Preference> tubers = [];
  List<Preference> fruits = [];
  List<PreferenceRegisterDto> preferencesFavorite = [];
  List<PreferenceRegisterDto> preferencesAllergy = [];
  List<Region> regionList = [];
  String userName = "", firstName = "", lastName = "", dni = "", email = "", password = "", rol = "", sex = "", birthDate = "",
      phone = "", licenseNumber = "", accessCode = "", doctorAccessCode = "";
  double height = 0.0, weight = 0.0, imc = 0.0, abdominal = 0.0, arm = 0.0, tmb = 0.0;
  int regionId = 0, doctorId = 0;
  late GlobalKey<FormState> userFormKey;
  late GlobalKey<FormState> rolFormKey;

  bool logged = false;

  late PatientRegisterDto patientRegisterDto;
  late DoctorRegisterDto doctorRegisterDto;

  final PageController pageController = PageController(initialPage: GoToPage.role);

  RegisterPresenter(BuildContext _context){
    context = _context;
    Provider.of<UserProvider>(context, listen: false).getAllRegions();
    setPreferencesLists();
    determineLocation();
  }

  void switchPage(int page) {
    if(page == 5){
      logged = true;
    }
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear
    );
  }

  bool validateUserFormKey(){
    return userFormKey.currentState!.validate();
  }

  bool validateRolFormKey(){
    return rolFormKey.currentState!.validate();
  }

  bool validateAccessCode(){
    return accessCode == doctorAccessCode;
  }

  determinateRegion(String addressRegion){
    String regionToValidate = addressRegion.substring(addressRegion.lastIndexOf(" ") + 1);
    regionToValidate = regionToValidate.toUpperCase();
    for(int i = 0; i < regionList.length; i ++){
      if(regionList[i].name == regionToValidate){
        regionId = regionList[i].regionId!;
        break;
      }
    }
  }

  determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position currentPosition;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getCurrentPosition();

    getAddressFromLatLng(currentPosition);

  }

  getAddressFromLatLng(Position _currentPosition) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude
      );

      Placemark place = placemarks[0];

      determinateRegion(place.administrativeArea!);

    } catch (e) {
      print(e);
    }
  }

  String setRol(int _desireRol){
    switch(_desireRol){
      case 1:
        return "p";
      case 2:
        return "d";
      default:
        return "p";
    }
  }

  String setSex(String _sex){
    switch(_sex){
      case "Masculino":
        return "h";
      case "Femenino":
        return "m";
      default:
        return "h";
    }
  }

  setPatientRegisterDto(){
    rol = setRol(desireRol);
    sex = setSex(sex);
    height = height * 100.0;
    patientRegisterDto = PatientRegisterDto(userName, firstName, lastName, dni, email, password, rol, sex, birthDate, phone, regionId, abdominal, arm, imc, tmb, height, weight);
  }

  setDoctorRegisterDto(){
    rol = setRol(desireRol);
    sex = setSex(sex);
    doctorRegisterDto = DoctorRegisterDto(userName, firstName, lastName, dni, email, password, rol, sex, birthDate, phone, licenseNumber);
  }

  setImc(){
    imc = weight/pow(height, 2);
  }

  setDesireRol(int _desireRol){
    desireRol = _desireRol;
  }

  setPreferencesLists(){
    Provider.of<PreferenceProvider>(context, listen: false).listAllPreferences().then((value){
      categorizeLists(value);
    });
  }

  categorizeLists(List<Preference> originalList){
    for(int i = 0; i < originalList.length; i++){
      if(originalList[i].category!.categoryId == 4){
        meats.add(originalList[i]);
        continue;
      }
      if(originalList[i].category!.categoryId == 14){
        vegetables.add(originalList[i]);
        continue;
      }
      if(originalList[i].category!.categoryId == 24){
        seafood.add(originalList[i]);
        continue;
      }
      if(originalList[i].category!.categoryId == 34){
        tubers.add(originalList[i]);
        continue;
      }
      if(originalList[i].category!.categoryId == 44){
        fruits.add(originalList[i]);
        continue;
      }
    }
  }

}