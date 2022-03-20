import 'package:flutter/material.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class UserRoleScreen extends StatefulWidget {
  UserRoleScreen({Key? key}) : super(key: key);

  @override
  _UserRoleScreenState createState() => _UserRoleScreenState();
}

class _UserRoleScreenState extends State<UserRoleScreen> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();
  int selected = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(height: 100),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.8,
              MediaQuery.of(context).size.height * 0.20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                color: Color(constants.primaryColor),
                width: 3.0,
              ),
            ),
            textStyle: const TextStyle(fontSize: 15),
            primary: selected == 1
                ? Color(constants.primaryColor)
                : Colors.white,
          ),
          onPressed: () {
            selected = selected == 1 ? 0 : 1;
            setState(() {
              Provider.of<UserProvider>(context, listen: false).registerPresenter.setDesireRol(1);
            });
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: EdgeInsets.only(right: 10, bottom: 20),
                child: Text(
                  'Paciente',
                  style: GoogleFonts.raleway(
                      color: selected == 1
                          ? Colors.white
                          : Color(constants.primaryColor),
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.8,
              MediaQuery.of(context).size.height * 0.20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                color: Color(constants.primaryColor),
                width: 3.0,
              ),
            ),
            textStyle: const TextStyle(fontSize: 15),
            primary: selected == 2
                ? Color(constants.primaryColor)
                : Colors.white,
          ),
          onPressed: () {
            selected = selected == 2 ? 0 : 2;
            setState(() {
              Provider.of<UserProvider>(context, listen: false).registerPresenter.setDesireRol(2);
            });
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: EdgeInsets.only(right: 10, bottom: 20),
                child: Text(
                  'Nutricionista',
                  style: GoogleFonts.raleway(
                      color: selected == 2
                          ? Colors.white
                          : Color(constants.primaryColor),
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ],
    );
  }
}
