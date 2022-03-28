import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/presenters/diet_day_detail_presenter.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/message.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/shimmers/food_option_shimmer.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/entities/meal.dart';
import 'food_option.dart';

class FoodDetail extends StatefulWidget {

  Meal meal;
  final Function(String) notifyParent;
  FoodDetail({Key? key, required this.meal, required this.notifyParent}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FoodDetailState();

}



class FoodDetailState extends State<FoodDetail> {
  final constants = Constants();
  int selected = 0;

  _showDialog(){
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (BuildContext context) {
        return Message(text: '¿Desea continuar con el cambio de dieta?', yesFunction: (){
          Provider.of<DietProvider>(context, listen: false).dayDetailPresenter.prepareNewMeal();
          Provider.of<DietProvider>(context, listen: false).replaceMeal(Provider.of<DietProvider>(context, listen: false).dayDetailPresenter.mealToReplace).then((value){
            if(value.mealId != null){
              Provider.of<DietProvider>(context, listen: false).dayDetailPresenter.afterMealChanged(value);
              Provider.of<DietProvider>(context, listen: false).dietPresenter.setNewMeal(value);
              Navigator.pop(context);
            }
          });
        }, noFunction: (){}, options: true,);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width/20, vertical: size.height/90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFFFFCC7E),
            ),
            width: size.width,
            height: size.height/1.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height/80),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: size.width/500,
                            widthFactor: size.width/500,
                            child: Image.network("https://blogladiadoresfit.com/wp-content/uploads/2021/02/avena-fitness.jpg", height: size.width/3,),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width/40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width/3,
                              height: 50,
                              child: Text(widget.meal.name.toString(), style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 15, fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              width: size.width/2.05,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD698),
                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.emoji_food_beverage_rounded, color: Colors.black, size: 10,),
                                        Text('  Ingredientes', style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 10, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height/15,
                                    child: Wrap(
                                      spacing: 2.0,
                                      runSpacing: 10.0,
                                      direction: Axis.vertical,
                                      children: List.generate(Provider.of<DietProvider>(context).dayDetailPresenter.ingredients.length, (index){
                                        return Text(Provider.of<DietProvider>(context).dayDetailPresenter.ingredients[index], style: TextStyle(color: Color(0xFF2D2D2D), fontSize: 10),);
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),)
                    ],
                  ),),
                Padding(
                  padding: EdgeInsets.only(top: size.height/80),
                  child: SizedBox(
                    width: size.width,
                    height: size.width/4,
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      palette: [
                        Color(0XFF02D871),
                        Color(0XFFFFEA29),
                        Color(0XFFFF003E)
                      ],
                      series: <ChartSeries>[
                        BarSeries<ProteinDetail, String>(
                            dataSource: Provider.of<DietProvider>(context).dayDetailPresenter.chartData,
                            xValueMapper: (ProteinDetail pd, _) => pd.protein,
                            yValueMapper: (ProteinDetail pd, _) => pd.q,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(color: Color(0xFF2D2D2D))
                            ))
                      ],
                      primaryXAxis: CategoryAxis(
                        borderColor: Color(0xFFFFCC7E),
                        borderWidth: 2,
                        labelStyle: TextStyle(color: Color(0xFF2D2D2D)),
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                          isVisible: false
                      ),),
                  ),
                ),
                Row(
                    children: [
                      Text("Opciones", style: TextStyle(color: Color(0xFF2D2D2D), fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: size.width/15,
                        child: IconButton(
                            onPressed: () {
                              Provider.of<DietProvider>(context, listen: false).getAlternativeMeals(Provider.of<DietProvider>(context, listen: false).dayDetailPresenter.mealSelected);
                            },
                            icon: Icon(CupertinoIcons.refresh_thin, color: Color(0xFF2D2D2D), size: size.width/25,)
                        ),
                      )
                    ],
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(3, (index) {
                    if(Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMealList.isNotEmpty){
                      return GestureDetector(
                        onTap: () {
                          Provider.of<DietProvider>(context, listen: false).setAlternativeMeal(Provider.of<DietProvider>(context, listen: false).dayDetailPresenter.alternativeMealList[index], true);
                        },
                        child: FoodOption(meal: Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMealList[index]),
                      );
                    }
                    else{
                      return FoodOptionShimmer();
                    }
                  }),),
              ],
            ),
          ),
          AnimatedPositioned(
              width: Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMeal.name != null ? size.width/3.2 : size.width/3.2,
              height: Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMeal.name != null ? 55.0 : 20.0,
              top: 8.0,
              right: Provider.of<DietProvider>(context).dayDetailPresenter.alternativeMeal.name != null ? 0.0 : -150.0,
              curve: Curves.fastOutSlowIn,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _showDialog();
                    },
                    child: Icon(CupertinoIcons.arrow_2_circlepath, color: Colors.white, size: size.height/50,),
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(size.height/10, size.height/10),
                      elevation: 0,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(size.height/90),
                      primary: Color(constants.primaryColor), // <-- Button color
                      onPrimary: Color(constants.primaryColor), // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Provider.of<DietProvider>(context, listen: false).setAlternativeMeal(Meal(), false);
                    },
                    child: Icon(CupertinoIcons.xmark, color: Colors.white, size: size.height/50,),
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(size.height/10, size.height/10),
                      elevation: 0,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(size.height/90),
                      primary: Colors.red, // <-- Button color
                      onPrimary: Color(constants.primaryColor), // <-- Splash color
                    ),
                  ),
                ],
              ),
              duration: Duration(seconds: 2))
        ],
      ),);
  }
}