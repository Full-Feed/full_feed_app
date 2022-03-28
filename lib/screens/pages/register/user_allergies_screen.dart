import 'package:flutter/material.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/authentication/food_check_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';


class UserAllergiesScreen extends StatefulWidget {
  String type;
  UserAllergiesScreen({Key? key, required this.type}) : super(key: key);

  @override
  UserAllergiesScreenState createState() => UserAllergiesScreenState();
}

class UserAllergiesScreenState extends State<UserAllergiesScreen> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width/15, vertical: size.height/50),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Selecciona que comidas te provocan alergias', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),)),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Carnes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.meats.length, (index) =>
                        FoodItem(
                          type: widget.type,
                          preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.meats[index],
                          imagePath: 'assets/1.png',
                          color: 0xFFFED3C5,
                        ),),
                  ),
                ),
              ),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Mariscos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.seafood.length, (index) =>
                        FoodItem(
                          type: widget.type,
                          preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.seafood[index],
                          imagePath: 'assets/1.png',
                          color: 0xFFD2E6FA,
                        ),),
                  ),
                ),
              ),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Verduras', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.vegetables.length, (index) =>
                        FoodItem(
                          type: widget.type,
                          preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.vegetables[index],
                          imagePath: 'assets/1.png',
                          color: 0xFFC7F5E2,
                        ),),
                  ),
                ),
              ),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Tuberculos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.tubers.length, (index) =>
                        FoodItem(
                          type: widget.type,
                          preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.tubers[index],
                          imagePath: 'assets/1.png',
                          color: constants.proteinItemColor,
                        ),
                    ),
                  ),
                ),
              ),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Frutas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.0,
                    runSpacing: 8.0,
                    children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.fruits.length, (index) =>
                        FoodItem(
                          type: widget.type,
                          preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.fruits[index],
                          imagePath: 'assets/1.png',
                          color: 0xFFFCE0FB,
                        ),),
                  ),
                ),
              ),),
            SizedBox(
              height: size.height/10,
            )
          ],
        ),
      ),
    ) ;
  }
}
