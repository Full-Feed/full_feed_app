import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/doctor_patient.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';
import 'diet_day_patient_detail.dart';

class DoctorPatientsList extends StatefulWidget {
  const DoctorPatientsList({Key? key}) : super(key: key);

  @override
  DoctorPatientsListState createState() => DoctorPatientsListState();
}

class DoctorPatientsListState extends State<DoctorPatientsList> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();
  bool isPressed = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height - 165,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width/20, vertical: 15.0),
          child: Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor.isNotEmpty ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pacientes', style: TextStyle(fontSize: size.width/20, color: Color(constants.primaryColor), fontWeight: FontWeight.bold),),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height/70),
                  child: ListView(
                    children: List.generate(Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor.length, (index) =>
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DietDayPatientDetail(patient: Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor[index],)),);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height/80),
                            child: DoctorPatient(title: "Paciente", patient: Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor[index],),
                          ),
                        )
                    ),
                  ),
                ),)
            ],
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.exclamationCircle, color: Colors.black26, size: size.width/10,),
                Text("Aun no tiene pacientes", style: TextStyle(color: Colors.black26),)
              ],
            ),
          ),
        )
    );
  }
}
