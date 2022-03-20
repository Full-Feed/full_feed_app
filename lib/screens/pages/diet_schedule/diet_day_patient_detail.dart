import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_feed_app/models/entities/patient.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/patient_detail_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


import '../../../presenters/profile_presenter.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/constants.dart';
import 'diet_calendar_page.dart';

class DietDayPatientDetail extends StatefulWidget {

  Patient patient;
  DietDayPatientDetail({Key? key, required this.patient}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DietDayPatientDetailState();

}

class GoToPage {
  static const int carbohydrates = 0;
  static const int proteins = 1;
}

class DietDayPatientDetailState extends State<DietDayPatientDetail> {
  final constants = Constants();
  String date = "";
  int foodSelected = 0;
  int currentIndex = 0;
  bool created = true;

  bool isPressed = false;
  final PageController _pageController = PageController(initialPage: GoToPage.carbohydrates);
  late PageController _dietPageController;

  void _switchPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(seconds: 1),
        curve: Curves.linear
    );
  }

  void _switchDietPage(int page) {
    _dietPageController.animateToPage(page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear
    );
  }


  @override
  void initState() {
    _dietPageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: size.height/25, left: size.width/50, right: size.width/50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(constants.logoImagePath, width: 40,
                          height: 40, fit: BoxFit.contain),
                      Image.asset(constants.logoTextPath, width: 70,
                          height: 70, fit: BoxFit.contain)
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 1.1,
                  child: PageView(
                    controller: _dietPageController,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                        Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back_ios_rounded, color: Color(constants.primaryColor),),
                                  ),
                                  Text("Volver", style: TextStyle(fontSize: 18, color: Color(constants.primaryColor), fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Row(
                                  children: [
                                    Text("Plan Dietetico", style: TextStyle(fontSize: 18, color: Color(constants.primaryColor), fontWeight: FontWeight.bold),),
                                    IconButton(
                                      onPressed: () {
                                        _switchDietPage(1);
                                      },
                                      icon: Icon(Icons.arrow_forward_ios_rounded, color: Color(constants.primaryColor),),
                                    ),
                                  ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white
                            ),
                            height: size.height/2.8,
                            width: size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                          color: Color(0xFFFFBAB9),
                                        ),
                                        child: Center(
                                          child: FaIcon(FontAwesomeIcons.user, color: Colors.white, size: 40,) ,
                                        )//Icon(Fa, size: 50, color: Color(constants.calendarColor),),
                                    ),
                                    const SizedBox(width: 20.0),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.patient.user!.lastName.toString(), style: TextStyle(fontWeight: FontWeight.w300),),
                                        Text(widget.patient.user!.firstName.toString(), style: TextStyle(fontWeight: FontWeight.w300)),
                                        Container(
                                          padding: EdgeInsets.only(top: size.height/50),
                                          width: size.width/2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(widget.patient.user!.email.toString(), style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 10)),
                                              Text(widget.patient.user!.phone.toString(), style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 10)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size.height/50),
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      PatientDetailCard(asset: "assets/height.svg", text: (widget.patient.height! / 100).toString() + " m", title: "Altura"),
                                      PatientDetailCard(asset: "assets/weight.svg", text: widget.patient.weight.toString() + " kg", title: "Peso"),
                                      PatientDetailCard(asset: "assets/bmi.svg", text: widget.patient.imc.toString(), title: "Imc"),
                                      PatientDetailCard(asset: "assets/age.svg", text: widget.patient.age.toString(), title: "Edad")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height/50,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white
                            ),
                            height: size.height/3.3,
                            width: size.width,
                            child: Column(
                              children: [
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
                                      elevation: 0,
                                      primary: Color(constants.primaryColor),
                                      fixedSize: const Size(350.0, 15.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)),),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(Icons.arrow_back_ios_rounded),
                                        Text('Carbohidratos', style: TextStyle(fontSize: 12),),
                                        Icon(Icons.arrow_forward_ios_rounded),
                                      ],
                                    ),
                                  ) : ElevatedButton(
                                    onPressed: (){
                                      _switchPage(GoToPage.carbohydrates);
                                      isPressed = !isPressed;
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Color(constants.chartTitleCardColor),
                                      fixedSize: const Size(350.0, 15.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.arrow_back_ios_rounded),
                                        Text('Proteínas', style: TextStyle(fontSize: 12)),
                                        Icon(Icons.arrow_forward_ios_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height/80,
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
                                              dataSource: Provider.of<UserProvider>(context, listen: false).profilePresenter.carbohydrateChartData,
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
                                              dataSource: Provider.of<UserProvider>(context, listen: false).profilePresenter.proteinChartData,
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
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height/50,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white
                            ),
                            height: size.height/3.5,
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.weight, color: Color(constants.primaryColor), size: 12,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Evolución del Peso', style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
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
                                        dataSource: Provider.of<UserProvider>(context, listen: false).profilePresenter.chartData,
                                        yValueMapper: (WeightData weight, _) => weight.lostWeight,
                                        xValueMapper: (WeightData weight, _) => weight.month.toString(),
                                        color: Color(constants.chartLineColor),
                                        width: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _switchDietPage(0);
                                    },
                                    icon: Icon(Icons.arrow_back_ios_rounded, color: Color(constants.primaryColor),),
                                  ),
                                  Text(widget.patient.user!.firstName.toString(), style: TextStyle(fontSize: 18, color: Color(constants.primaryColor), fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white
                            ),
                            height: size.height/1.5,
                            width: size.width,
                            child: DietCalendarPage(patient: widget.patient,),
                          )
                        ],
                      )
                    ],
                  ),),
              ],
            ),
          )
      ),
    );
  }
}