

import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/dtos/meal_replace_dto.dart';
import 'package:full_feed_app/models/entities/meal.dart';

class ProteinDetail {
  final String protein;
  final double q;

  ProteinDetail(this.protein, this.q);
}


class DietDayDetailPresenter {
  var context;
  List<ProteinDetail> chartData = [];

  int selected = 0;
  bool changeFood = false;
  late List<Meal> dayMeals = [];
  Meal mealSelected = Meal();
  late MealReplaceDto mealToReplace;
  List<String> ingredients = [];
  Meal alternativeMeal = Meal();
  late List<Meal> alternativeMealList = [];

  DietDayDetailPresenter(BuildContext _context, List<Meal> meals){
    context = _context;
    dayMeals = meals;
    mealSelected = dayMeals[0];
    splitIngredients(false);
    generateData();
  }

  prepareNewMeal(){
    mealToReplace = MealReplaceDto(mealSelected.mealId!, alternativeMeal.name!, alternativeMeal.carbohydrates!,
        alternativeMeal.fat!, alternativeMeal.gramsPortion!, alternativeMeal.ingredients!, alternativeMeal.protein!, alternativeMeal.totalCalories!,
        alternativeMeal.imageUrl!);
  }

  afterMealChanged(Meal newMeal){
    for(int i = 0; i < dayMeals.length; i++){
      if(dayMeals[i].mealId == newMeal.mealId){
        dayMeals[i] = newMeal;
      }
    }
    mealSelected = newMeal;
  }

  splitIngredients(bool alternative){
    if(alternative){
      ingredients = alternativeMeal.ingredients!.split('-');
      for(int i =0; i<ingredients.length; i ++){
        ingredients[i] = ingredients[i].substring(0, 1) + ingredients[i].substring(1).toLowerCase();
      }
    }
    else{
      ingredients = mealSelected.ingredients!.split('-');
      for(int i =0; i<ingredients.length; i ++){
        ingredients[i] = ingredients[i].substring(0, 1) + ingredients[i].substring(1).toLowerCase();
      }
    }
  }

  setDay(int day){
    String dayName = "";
    switch(day){
      case 1:
        dayName = "Lun";
        break;
      case 2:
        dayName = "Mar";
        break;
      case 3:
        dayName = "Mie";
        break;
      case 4:
        dayName = "Jue";
        break;
      case 5:
        dayName = "Vie";
        break;
      case 6:
        dayName = "Sab";
        break;
      case 7:
        dayName = "Dom";
        break;
    }
    return dayName;
  }


  generateData(){

    if(chartData.isNotEmpty){
      chartData.clear();
    }
    if(alternativeMeal.name != null){
      chartData = [
        ProteinDetail('Peso', double.parse(alternativeMeal.gramsPortion.toString())),
        ProteinDetail('Grasas', double.parse(alternativeMeal.fat.toString())),
        ProteinDetail('Proteinas', double.parse(alternativeMeal.protein.toString())),
        ProteinDetail('Carbohidratos', double.parse(alternativeMeal.carbohydrates.toString())),
      ];
    }
    else{
      chartData = [
        ProteinDetail('Peso', double.parse(mealSelected.gramsPortion.toString())),
        ProteinDetail('Grasas', double.parse(mealSelected.fat.toString())),
        ProteinDetail('Proteinas', double.parse(mealSelected.protein.toString())),
        ProteinDetail('Carbohidratos', double.parse(mealSelected.carbohydrates.toString())),
      ];
    }
  }

}