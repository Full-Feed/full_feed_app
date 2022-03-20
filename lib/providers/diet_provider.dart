
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/dtos/meal_replace_dto.dart';
import 'package:full_feed_app/models/entities/patient.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/presenters/home_presenter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/entities/meal.dart';
import '../presenters/diet_calendar_presenter.dart';
import '../presenters/diet_day_detail_presenter.dart';
import '../utilities/connection_tags.dart';

class DietProvider with ChangeNotifier {

  final connectionTags = ConnectionTags();
  late BasicDietCalendarPresenter dietPresenter;
  late HomePresenter homePresenter;
  late DietDayDetailPresenter dayDetailPresenter;

  homePresenterChange(){
    notifyListeners();
  }

  setMealsReady(bool _mealsReady){
    homePresenter.mealsReady = _mealsReady;
    notifyListeners();
  }

  initDietPresenter(BuildContext context, DateRangePickerController _controller, Patient? patient){
    dietPresenter = BasicDietCalendarPresenter(context, _controller, patient);
  }

  initHomePresenter(BuildContext context){
    homePresenter = HomePresenter(context);
  }

  initDayDetailPresenter(BuildContext context){
    dayDetailPresenter = DietDayDetailPresenter(context);
  }

  setMealSelected(Meal selected){
    dayDetailPresenter.mealSelected = selected;
    dayDetailPresenter.generateData();
    dayDetailPresenter.splitIngredients(false);
    getAlternativeMeals(selected);
    notifyListeners();
  }

  setAlternativeMeal(Meal alternativeMeal, bool _changeFood){
    dayDetailPresenter.changeFood = _changeFood;
    dayDetailPresenter.alternativeMeal = alternativeMeal;
    dayDetailPresenter.splitIngredients(_changeFood);
    dayDetailPresenter.generateData();
    notifyListeners();
  }


  Future<bool> getWeekDietMeals() async{

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.weekMealList;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.get(api, queryParameters: {'endDate' : dateFormat.format(dietPresenter.last), 'patientId' : UserSession().profileId, 'startDate': dateFormat.format(dietPresenter.initial)});
    if(response.statusCode == 200){
      List aux = response.data.map((e) => Meal.fromJson(e)).toList();
      dietPresenter.weekMealList = aux.cast<Meal>();
      return true;
    }
    return false;
  }

  Future<bool> getWeekDietMealsByPatient(int patientId) async{

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.weekMealList;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.get(api, queryParameters: {'endDate' : dateFormat.format(dietPresenter.last), 'patientId' : patientId, 'startDate': dateFormat.format(dietPresenter.initial)});
    if(response.statusCode == 200){
      List aux = response.data.map((e) => Meal.fromJson(e)).toList();
      dietPresenter.weekMealList = aux.cast<Meal>();
      return true;
    }
    return false;
  }


  Future<bool> getDayMeals() async{
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.dayMealList;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.get(api, queryParameters: {'date' : today, 'patientId' : UserSession().profileId});
    if(response.statusCode == 200){
      List aux = response.data.map((e) => Meal.fromJson(e)).toList();
      homePresenter.dayMealList = aux.cast<Meal>();
      return true;
    }
    return false;
  }

  Future<List<Meal>> getDayMealsByPatient(int patientId) async{
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.dayMealList;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.get(api, queryParameters: {'date' : today, 'patientId' : patientId});
    if(response.statusCode == 200){
      List aux = response.data.map((e) => Meal.fromJson(e)).toList();
      return aux.cast<Meal>();
    }
    return [];
  }

  getAlternativeMeals(Meal meal) async{
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.alternativeMeals;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.post(api, data: {'calories': meal.totalCalories, 'schedule': meal.schedule});
    if(response.statusCode == 200){
      List aux = response.data["data"].map((e) => Meal.fromJson(e)).toList();
      dayDetailPresenter.alternativeMealList = aux.cast<Meal>();
    }
    notifyListeners();
  }

  Future<bool> generateNutritionPlan(int patientId, int doctorId, BuildContext context) async {
    final api = connectionTags.baseUrl + connectionTags.patientEndpoint + connectionTags.newNutritionalPlan;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.post(api, queryParameters: {'patientId' : patientId, 'doctorId' : doctorId});
    if(response.statusCode == 201){
      List aux = response.data['data'].map((e) => Meal.fromJson(e)).toList();
      Provider.of<DietProvider>(context, listen: false).dietPresenter.weekMealList = aux.cast<Meal>();
      Provider.of<DietProvider>(context, listen: false).dietPresenter.initial = DateTime.parse(response.data['data'][0]['day']);
      return true;
    }
    return false;
  }

  Future<bool> completeMeal(int mealId) async {
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.completeMeal;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.put(api, queryParameters: {'mealId' : mealId});
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  Future<bool> restoreMeal(int mealId) async {
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.restoreMeal;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.put(api, queryParameters: {'mealId' : mealId});
    if(response.statusCode == 200){
      return false;
    }
    return true;
  }

  Future<Meal> replaceMeal(MealReplaceDto meal) async {
    final api = connectionTags.baseUrl + connectionTags.mealEndpoint + connectionTags.replaceMeal;
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().token}";
    Response response;
    response = await dio.put(api, data: jsonEncode(meal));
    if(response.statusCode == 200){
      Meal aux = Meal.fromJson(response.data["data"]);
      return aux;
    }
    return Meal();
  }

}
