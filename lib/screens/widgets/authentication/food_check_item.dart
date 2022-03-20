import 'package:flutter/material.dart';
import 'package:full_feed_app/models/dtos/preference_register.dart';
import 'package:full_feed_app/models/entities/preference.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';

class FoodItem extends StatefulWidget {

  final String imagePath;
  final Preference preference;
  final String type;
  final int color;
  const FoodItem({Key? key, required this.imagePath, required this.preference, required this.type,
    required this.color}) : super(key: key);

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  final constants = Constants();
  bool selected = false;
  
  String prepareString(String originalText){
    return originalText.substring(0, 1) + originalText.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        if(selected == false){
          if(widget.type == "FAVORITE"){
            Provider.of<UserProvider>(context, listen: false).registerPresenter.preferencesFavorite.add(PreferenceRegisterDto(widget.preference.preferencesId!, widget.type));
          }
          else{
            Provider.of<UserProvider>(context, listen: false).registerPresenter.preferencesAllergy.add(PreferenceRegisterDto(widget.preference.preferencesId!, widget.type));
          }
        }
        else{
          if(widget.type == "FAVORITE"){
            Provider.of<UserProvider>(context, listen: false).registerPresenter.preferencesFavorite.removeWhere((element) => element.preferenceId == widget.preference.preferencesId);
          }
          else{
            Provider.of<UserProvider>(context, listen: false).registerPresenter.preferencesAllergy.removeWhere((element) => element.preferenceId == widget.preference.preferencesId);
          }
        }
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Color(widget.color),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height/120),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(prepareString(widget.preference.name.toString()), style: TextStyle(fontSize: 10),),
                    ),),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(widget.imagePath, fit: BoxFit.contain, width: 45, height: 45)),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Transform.scale(
                  scale: 0.9,
                  child: Checkbox(
                      side: BorderSide(
                          style: BorderStyle.none
                      ),
                      value: selected,
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Color(constants.primaryColor)),
                      activeColor: Color(constants.primaryColor),
                      shape: const CircleBorder(),
                      onChanged: (value) {
                      }),
                ),
              )
            ],
          )
      ),
    );
  }
}
