import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:full_feed_app/utilities/constants.dart';

class FoodDetail extends StatefulWidget {

  String plato;

  FoodDetail({Key? key, required this.plato}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FoodDetailState();

}

class ProteinDetail {
  final String protein;
  final int q;

  ProteinDetail(this.protein, this.q);
}

class FoodDetailState extends State<FoodDetail> {
  final constants = Constants();
  List<charts.Series<ProteinDetail, String>> _seriesData = [];
  int selected = 0;


  generateData(){
    var data1 = [
      new ProteinDetail('Carbohidratos', 16),
      new ProteinDetail('Proteinas', 3),
      new ProteinDetail('Grasas', 52),
      new ProteinDetail('Peso', 120),
    ];

    setState(() {
      _seriesData.add(
        charts.Series(
          domainFn: (ProteinDetail proteinDetail, _) => proteinDetail.protein,
          measureFn: (ProteinDetail proteinDetail, _) => proteinDetail.q,
          id: '2017',
          data: data1,
          fillPatternFn: (_, __) => charts.FillPatternType.solid,

          labelAccessorFn: (ProteinDetail proteinDetail, _) =>
          '${proteinDetail.q}',
          fillColorFn: (ProteinDetail proteinDetail, _) =>
          proteinDetail.q > 100 ? charts.ColorUtil.fromDartColor(Color(0xFFFF295C)) : proteinDetail.q > 50 ? charts.ColorUtil.fromDartColor(Color(0xFFFFEA29)) : charts.ColorUtil.fromDartColor(Color(0xFF29FF8B)),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    generateData();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var size2 = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size/20, vertical: size2/90),
        decoration: BoxDecoration(
          color: Color(constants.mealDetailColor),
        ),
        width: size,
        height: size2/5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Desayuno Avena"),
            Padding(
              padding: EdgeInsets.only(top: size2/80),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Align(
                        alignment: Alignment.center,
                        heightFactor: size/500,
                        widthFactor: size/500,
                        child: Image.network("https://blogladiadoresfit.com/wp-content/uploads/2021/02/avena-fitness.jpg", height: size/3,),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size/20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1 tazón de avena"),
                        SizedBox(
                          width: size/2.2,
                          height: size/4,
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            vertical: false,
                            barRendererDecorator: charts.BarLabelDecorator<String>(),
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            primaryMeasureAxis:
                            charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
                            animationDuration: Duration(seconds: 5),),
                        )
                      ],
                    ),)
                ],
              ),)
          ],
        ),
      ),);
  }
}