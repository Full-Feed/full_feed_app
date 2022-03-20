import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/nutrition_stat.dart';
import 'package:full_feed_app/models/entities/weight_history.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:provider/provider.dart';


class WeightData {
  final double lostWeight;
  final String month;

  WeightData(this.lostWeight, this.month);
}

class CarbohydrateData {
  final double kCal;
  final String days;

  CarbohydrateData(this.kCal, this.days);
}

class ProteinData {
  final double kCal;
  final String days;

  ProteinData(this.kCal, this.days);
}


class ProfilePresenter{

  List<NutritionStat> nutritionStats = [];
  List<WeightHistory> weightHistory = [];
  List<WeightData> chartData = [];
  List<CarbohydrateData> carbohydrateChartData = [];
  List<ProteinData> proteinChartData = [];
  var context;

  ProfilePresenter(BuildContext _context){
    Provider.of<UserProvider>(_context, listen: false).getConsumedBalance();
    context = _context;
    generateWeightHistory();
    generateNutritionStats();
  }

  generateWeightHistory(){
    if(weightHistory.isNotEmpty){
      for(int i = 0; i < weightHistory.length; i++){
        chartData.add(WeightData(weightHistory[i].weight!, getMonth(weightHistory[i].date!)));
      }
    }
    else{
      chartData = [
        WeightData(0, 'Ene'),
        WeightData(0, 'Feb'),
        WeightData(0, 'Mar'),
        WeightData(0, 'Abr'),
        WeightData(0, 'May'),
        WeightData(0, 'Jun'),
        WeightData(0, 'Jul'),
        WeightData(0, 'Ago'),
        WeightData(0, 'Set'),
        WeightData(0, 'Oct'),
        WeightData(0, 'Nov'),
        WeightData(0, 'Dic'),
      ];
    }
  }

  String getMonth(String date){
    DateTime aux = DateTime.parse(date);
    String day = "";
    switch(aux.month){
      case 1:
        day = "Ene";
        break;
      case 2:
        day = "Feb";
        break;
      case 3:
        day = "Mar";
        break;
      case 4:
        day = "Abr";
        break;
      case 5:
        day = "May";
        break;
      case 6:
        day = "Jun";
        break;
      case 7:
        day = "Jul";
        break;
      case 8:
        day = "Ago";
        break;
      case 9:
        day = "Set";
        break;
      case 10:
        day = "Oct";
        break;
      case 11:
        day = "Nov";
        break;
      case 12:
        day = "Dic";
        break;
    }
    return day;
  }

  String getDay(String date){
    DateTime aux = DateTime.parse(date);
    String day = "";
    switch(aux.weekday){
      case 1:
        day = "Lun";
        break;
      case 2:
        day = "Mar";
        break;
      case 3:
        day = "Mie";
        break;
      case 4:
        day = "Jue";
        break;
      case 5:
        day = "Vie";
        break;
      case 6:
        day = "Sab";
        break;
      case 7:
        day = "Dom";
        break;
    }
    return day;
  }

  generateNutritionStats(){
    if(nutritionStats.isNotEmpty){
      for(int i = 0; i < nutritionStats.length; i++){
        carbohydrateChartData.add(CarbohydrateData(nutritionStats[i].carbohydrates!, getDay(nutritionStats[i].date!)));
        proteinChartData.add(ProteinData(nutritionStats[i].protein!,  getDay(nutritionStats[i].date!)));
      }
    }

    else{
      carbohydrateChartData = [
        CarbohydrateData(0, 'Lun'),
        CarbohydrateData(0, 'Mar'),
        CarbohydrateData(0, 'Mie'),
        CarbohydrateData(0, 'Jue'),
        CarbohydrateData(0, 'Vie'),
        CarbohydrateData(0, 'Sab'),
        CarbohydrateData(0, 'Dom'),
      ];

      proteinChartData = [
        ProteinData(0, 'Lun'),
        ProteinData(0, 'Mar'),
        ProteinData(0, 'Mie'),
        ProteinData(0, 'Jue'),
        ProteinData(0, 'Vie'),
        ProteinData(0, 'Sab'),
        ProteinData(0, 'Dom'),
      ];
    }
  }

}