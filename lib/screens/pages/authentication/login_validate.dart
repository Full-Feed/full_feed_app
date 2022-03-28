
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class LoginValidate extends StatefulWidget {
  const LoginValidate({Key? key}) : super(key: key);

  @override
  LoginValidateState createState() => LoginValidateState();
}

class LoginValidateState extends State<LoginValidate> {

  final constants = Constants();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).loginPresenter.doLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Color(constants.primaryColor),
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset("assets/fullfeedwhite.png", width: size.width/10,),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: size.width/6,
                height: size.width/6,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}