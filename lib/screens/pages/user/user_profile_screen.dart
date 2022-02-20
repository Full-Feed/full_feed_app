import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/user/user_profile_completed_days.dart';
import 'package:full_feed_app/screens/widgets/user/user_profile_weight.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class WeightData {
  final int lostWeight;
  final String month;

  WeightData(this.lostWeight, this.month);
}

class CarbohydrateData {
  final int kCal;
  final String days;

  CarbohydrateData(this.kCal, this.days);
}

class ProteinData {
  final int kCal;
  final String days;

  ProteinData(this.kCal, this.days);
}

class GoToPage {
  static const int carbohydrates = 0;
  static const int proteins = 1;
}

class _UserProfileScreenState extends State<UserProfileScreen> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();
  bool isPressed = false;
  final PageController _pageController = PageController(initialPage: GoToPage.carbohydrates);

  void _switchPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: size.height - 165,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            )
          ]
      ),
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/json.json'),
        builder: (context, snapshot) {
          //leer el json creado
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var getData = json.decode(snapshot.data.toString());

              // ---- SE OBTIENE DEL BACKEND EL PESO ACTUAL POR MES ---- //
              final List<WeightData> chartData = [
                WeightData(getData['monthlyWeight'][0]['actualWeight'], 'Ene'),
                WeightData(getData['monthlyWeight'][1]['actualWeight'], 'Feb'),
                WeightData(getData['monthlyWeight'][2]['actualWeight'], 'Mar'),
                WeightData(getData['monthlyWeight'][3]['actualWeight'], 'Abr'),
                WeightData(getData['monthlyWeight'][4]['actualWeight'], 'May'),
                WeightData(getData['monthlyWeight'][5]['actualWeight'], 'Jun'),
                WeightData(getData['monthlyWeight'][6]['actualWeight'], 'Jul'),
                WeightData(getData['monthlyWeight'][7]['actualWeight'], 'Ago'),
                WeightData(getData['monthlyWeight'][8]['actualWeight'], 'Set'),
                WeightData(getData['monthlyWeight'][9]['actualWeight'], 'Oct'),
                WeightData(getData['monthlyWeight'][10]['actualWeight'], 'Nov'),
                WeightData(getData['monthlyWeight'][11]['actualWeight'], 'Dic'),
              ];

              // ---- SE OBTIENE DEL BACKEND LO CONSUMIDO POR SEMANA ---- //
              final List<CarbohydrateData> carbohydrateChartData = [
                CarbohydrateData(80, 'Lun'),
                CarbohydrateData(20, 'Mar'),
                CarbohydrateData(30, 'Mie'),
                CarbohydrateData(30, 'Jue'),
                CarbohydrateData(155, 'Vie'),
                CarbohydrateData(200, 'Sab'),
                CarbohydrateData(180, 'Dom'),
              ];

              // ---- SE OBTIENE DEL BACKEND LO CONSUMIDO POR SEMANA ---- //
              final List<ProteinData> proteinChartData = [
                ProteinData(30, 'Lun'),
                ProteinData(50, 'Mar'),
                ProteinData(200, 'Mie'),
                ProteinData(130, 'Jue'),
                ProteinData(50, 'Vie'),
                ProteinData(40, 'Sab'),
                ProteinData(230, 'Dom'),
              ];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 85, width: size.width, color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                              color: Color(constants.userPicBorderColor),
                              width: 4,
                            ),
                            color: Colors.white,
                          ),
                          //TODO: necesita lógica si el experto tiene o no una foto, se requiere condicional de poner un ícono de usuario o imagen
                          child: Icon(Icons.account_circle, size: 50, color: Colors.amber,),
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getData['name'] + getData['lastName']),
                            //Text(getAge(getData['birthDate']),
                            Text(getData['height'].toString() + ' m')
                          ],
                        ),
                        const Spacer(),
                        Align(
                            alignment: Alignment.topRight,
                            child: Ink(
                                child: InkWell(
                                    onTap: (){},
                                    child: FaIcon(FontAwesomeIcons.cog, color: Color(constants.cogColor))
                                )
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 120, width: size.width, color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CompletedDaysItem(
                            completedDays: getData['completedDays'].toString()
                        ),
                        const SizedBox(width: 25),
                        LostWeightItem(
                            lostWeight: getData['lostWeight'].toString()
                        )
                      ],
                    ),
                  ),
                  const Text('Balance consumido'),
                  Align(
                    alignment: Alignment.center,
                    child: isPressed == false ?
                    ElevatedButton(
                      onPressed: (){
                        _switchPage(GoToPage.proteins);
                        isPressed = !isPressed;
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(constants.chartTitleCardColor),
                        fixedSize: const Size(265.0, 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),),
                      child: const Text('Carbohidratos'),
                    ) : ElevatedButton(
                      onPressed: (){
                        _switchPage(GoToPage.carbohydrates);
                        isPressed = !isPressed;
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(constants.chartTitleCardColor),
                        fixedSize: const Size(265.0, 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      child: const Text('Proteínas'),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height / 5.5,
                    child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        children: [
                          SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true),
                            tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: true),
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              labelPlacement: LabelPlacement.betweenTicks,
                              interval: 1,
                              labelStyle: GoogleFonts.lato(),
                            ),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              minimum: 0,
                              maximum: 250,
                              interval: 50,
                              decimalPlaces: 1,
                              labelFormat: '{value} kcal',
                              labelStyle: GoogleFonts.lato(),
                            ),
                            series: <CartesianSeries> [
                              ColumnSeries<CarbohydrateData, String>(
                                dataSource: carbohydrateChartData,
                                yValueMapper: (CarbohydrateData carbohydrate, _)
                                => carbohydrate.kCal,
                                xValueMapper: (CarbohydrateData carbohydrate, _)
                                => carbohydrate.days.toString(),
                                color: Color(constants.columnChartColor),
                                width: 0.5,
                              ),
                            ],
                          ),
                          SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true),
                            tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: true),
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              labelPlacement: LabelPlacement.betweenTicks,
                              interval: 1,
                              labelStyle: GoogleFonts.lato(),
                            ),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              minimum: 0,
                              maximum: 250,
                              interval: 50,
                              decimalPlaces: 1,
                              labelFormat: '{value} kcal',
                              labelStyle: GoogleFonts.lato(),
                            ),
                            series: <CartesianSeries> [
                              ColumnSeries<ProteinData, String>(
                                dataSource: proteinChartData,
                                yValueMapper: (ProteinData protein, _) => protein.kCal,
                                xValueMapper: (ProteinData protein, _) => protein.days.toString(),
                                color: Color(constants.columnChartColor),
                                width: 0.5,
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                  const Text('Peso'),
                  SizedBox(
                    width: size.width,
                    height: size.height / 4.5,
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true),
                      tooltipBehavior: TooltipBehavior(enable: true, header: '', canShowMarker: true),
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        labelPlacement: LabelPlacement.betweenTicks,
                        interval: 1,
                        labelStyle: GoogleFonts.lato(),
                      ),
                      primaryYAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        minimum: 75,
                        maximum: 125,
                        interval: 10,
                        decimalPlaces: 1,
                        labelFormat: '{value} Kg',
                        labelStyle: GoogleFonts.lato(),
                      ),
                      series: <ChartSeries> [
                        LineSeries<WeightData, String>(
                          dataSource: chartData,
                          yValueMapper: (WeightData weight, _) => weight.lostWeight,
                          xValueMapper: (WeightData weight, _) => weight.month.toString(),
                          color: Color(constants.chartLineColor),
                          width: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}


