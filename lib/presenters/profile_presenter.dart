import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/nutrition_stat.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/models/entities/weight_history.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/utilities/util.dart';
import 'package:provider/provider.dart';


class WeightData {
  final double? lostWeight;
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
  Util util = Util();
  var context;

  ProfilePresenter(BuildContext _context){
    context = _context;
    if(UserSession().rol == 'p'){
      Provider.of<UserProvider>(_context, listen: false).getConsumedBalance();
      Provider.of<UserProvider>(_context, listen: false).getWeightEvolution();
      generateWeightHistory();
      generateNutritionStats();
    }
  }

  generateWeightHistory(){
    if(weightHistory.isNotEmpty){
      for(int i = 0; i < weightHistory.length; i++){
        chartData.add(WeightData(weightHistory[i].weight!, util.getMonth(weightHistory[i].date!)));
      }
    }
    else{
      chartData = [
        WeightData(null, 'Ene'),
        WeightData(null, 'Feb'),
        WeightData(null, 'Mar'),
        WeightData(null, 'Abr'),
        WeightData(null, 'May'),
        WeightData(null, 'Jun'),
        WeightData(null, 'Jul'),
        WeightData(null, 'Ago'),
        WeightData(null, 'Set'),
        WeightData(null, 'Oct'),
        WeightData(null, 'Nov'),
        WeightData(null, 'Dic'),
      ];
    }
  }

  generateNutritionStats(){
    if(nutritionStats.isNotEmpty){
      for(int i = 0; i < nutritionStats.length; i++){
        carbohydrateChartData.add(CarbohydrateData(nutritionStats[i].carbohydrates!, util.getDay(nutritionStats[i].date!)));
        proteinChartData.add(ProteinData(nutritionStats[i].protein!,  util.getDay(nutritionStats[i].date!)));
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