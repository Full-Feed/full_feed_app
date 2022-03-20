import 'package:flutter/material.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/authentication/food_check_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import 'loading_screen.dart';


class UserLikesScreen extends StatefulWidget {
  String type;
  UserLikesScreen({Key? key, required this.type}) : super(key: key);

  @override
  _UserLikesScreenState createState() => _UserLikesScreenState();
}

class _UserLikesScreenState extends State<UserLikesScreen> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).registerAndLogin(),
        builder: (context, snapshot){
          if(snapshot.data == false || snapshot.data == null){
            return LoadingScreen(text: "Estamos configurando tu cuenta...", register: false,);
          }
          else{
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width/15, vertical: size.height/50),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Selecciona que comidas te gustan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),)),),
                    Padding(
                      padding: EdgeInsets.only(left: size.width/10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Carnes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.height/50),
                      child: Container(
                        height: Provider.of<UserProvider>(context, listen: false).registerPresenter.meats.length <= 3 ? size.height/5.5 :
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.meats.length <= 6 ? size.height/4.5 : size.height/2.8,
                        width: size.width/1.45,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6.0,
                          runSpacing: 8.0,
                          children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.meats.length, (index) =>
                              FoodItem(
                                type: "FAVORITE",
                                preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.meats[index],
                                imagePath: 'assets/1.png',
                                color: 0xFFFED3C5,
                              ),),
                        ),
                      ),),
                    Padding(
                      padding: EdgeInsets.only(left: size.width/10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Mariscos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.height/50),
                      child: Container(
                        height: Provider.of<UserProvider>(context, listen: false).registerPresenter.seafood.length <= 3 ? size.height/5.5 :
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.seafood.length <= 6 ? size.height/4.5 : size.height/2.8,
                        width: size.width/1.45,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6.0,
                          runSpacing: 8.0,
                          children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.seafood.length, (index) =>
                              FoodItem(
                                type: "FAVORITE",
                                preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.seafood[index],
                                imagePath: 'assets/1.png',
                                color: 0xFFD2E6FA,
                              ),),
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
                        height: Provider.of<UserProvider>(context, listen: false).registerPresenter.vegetables.length <= 3 ? size.height/5.5 :
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.vegetables.length <= 6 ? size.height/4.5 : size.height/2.8,
                        width: size.width/1.45,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6.0,
                          runSpacing: 8.0,
                          children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.vegetables.length, (index) =>
                              FoodItem(
                                type: "FAVORITE",
                                preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.vegetables[index],
                                imagePath: 'assets/1.png',
                                color: 0xFFC7F5E2,
                              ),),
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
                        height: Provider.of<UserProvider>(context, listen: false).registerPresenter.tubers.length <= 3 ? size.height/5.5 :
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.tubers.length <= 6 ? size.height/4.5 : size.height/2.8,
                        width: size.width/1.45,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6.0,
                          runSpacing: 8.0,
                          children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.tubers.length, (index) =>
                              FoodItem(
                                type: "FAVORITE",
                                preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.tubers[index],
                                imagePath: 'assets/1.png',
                                color: constants.proteinItemColor,
                              ),),
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
                        height: Provider.of<UserProvider>(context, listen: false).registerPresenter.fruits.length <= 3 ? size.height/5.5 :
                        Provider.of<UserProvider>(context, listen: false).registerPresenter.fruits.length <= 6 ? size.height/4.5 : size.height/2.8,
                        width: size.width/1.45,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 6.0,
                          runSpacing: 8.0,
                          children: List.generate(Provider.of<UserProvider>(context, listen: false).registerPresenter.fruits.length, (index) =>
                              FoodItem(
                                type: widget.type,
                                preference: Provider.of<UserProvider>(context, listen: false).registerPresenter.fruits[index],
                                imagePath: 'assets/1.png',
                                color: 0xFFFCE0FB,
                              ),),
                        ),
                      ),),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}
