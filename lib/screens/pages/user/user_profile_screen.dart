
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/user_provider.dart';

import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/user/user_profile_completed_days.dart';
import 'package:full_feed_app/screens/widgets/user/user_profile_weight.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../presenters/profile_presenter.dart';
import '../../widgets/diet_schedule/message.dart';
import '../authentication/authentication_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
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
  late TextEditingController pinController;

  void _switchPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear
    );
  }

  _showDialog(){
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (BuildContext context) {
        return Message(text: '¿Seguro desea cerrar sesión?', yesFunction: (){
          Provider.of<UserProvider>(context, listen: false).logOut();
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  type: PageTransitionType.rightToLeft,
                  child: const AuthenticationScreen()
              )
          );
        }, noFunction: (){}, options: true,);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).initProfilePresenter(context);
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: size.height/4,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                )
              ]
          ),
          child: Column(
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
                        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                        border: Border.all(
                          color: Color(constants.primaryColor),
                          width: 4,
                        ),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.account_circle, size: 50, color: Color(constants.primaryColor),),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(UserSession().userLastName),
                        Text(UserSession().userFirstName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const Spacer(),
                    Align(
                        alignment: Alignment.topRight,
                        child: Ink(
                            child: InkWell(
                                onTap: (){
                                  _showDialog();
                                },
                                child: FaIcon(FontAwesomeIcons.signOutAlt, color: Color(constants.primaryColor))
                            )
                        )
                    )
                  ],
                ),
              ),
              Container(
                height: 120, width: size.width, color: Colors.transparent,
                child: UserSession().rol == "p" ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CompletedDaysItem(
                        completedDays: UserSession().successfulDays.toString()
                    ),
                    const SizedBox(width: 25),
                    LostWeightItem(
                        lostWeight: UserSession().lossWeight.toString()
                    )
                  ],
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.personBooth, color: Color(0xFFFFAC33), size: 40,),
                        Text(UserSession().activePatients.toString(),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                        ),
                        const Text('Pacientes', style: TextStyle(fontSize: 10.5))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        UserSession().rol == "p" ? Container(
          margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: size.height/1.8,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                )
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child:  Row(
                  children: [
                    FaIcon(FontAwesomeIcons.balanceScale, color: Color(constants.primaryColor), size: 12,),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Balance consumido', style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
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
                    primary: const Color(0xFF20D0CE),
                    fixedSize: const Size(350.0, 20.0),
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
                    primary: Color(constants.chartTitleCardColor),
                    fixedSize: const Size(350.0, 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.arrow_back_ios_rounded),
                      Text('Proteinas', style: TextStyle(fontSize: 12),),
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
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
                          maximum: 500,
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
                          maximum: 500,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.weight, color: Color(constants.primaryColor), size: 12,),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Evolución del Peso', style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
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
                    minimum: 50,
                    maximum: 100,
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
              )
            ],
          ),
        ) : Container(
          margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: size.height/1.8,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                )
              ]
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child:  Row(
                  children: [
                    FaIcon(FontAwesomeIcons.qrcode, color: Color(constants.primaryColor), size: 12,),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Codigo de registro', style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width/15, right: size.width/15, top: size.height/20),
                child: PinCodeTextField(
                  length: 5,
                  appContext: context,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    activeColor: Colors.grey,
                    inactiveColor: Colors.grey,
                    selectedColor: Color(constants.primaryColor),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 45,
                    fieldWidth: 40,

                  ),
                  animationDuration: Duration(milliseconds: 300),
                  controller: pinController,
                  onCompleted: (v) {

                  },
                  onChanged: (value) {
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: size.height/50),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Color(constants.primaryColor), Color(0xFFFE7EB4)],
                            stops: [0.05, 1]
                        )
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Provider.of<UserProvider>(context, listen: false).generateAccessCode().then((value){
                          setState(() {
                            pinController.text = value;
                          });
                        });
                      },
                      child: Icon(CupertinoIcons.refresh, color: Colors.white, size: size.height/20,),
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size( 100,  100),
                        elevation: 0,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.transparent, // <-- Button color
                        onPrimary: Colors.transparent, // <-- Splash color
                      ),
                    ),
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}


