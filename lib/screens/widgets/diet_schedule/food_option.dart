
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/meal.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class FoodOption extends StatefulWidget {

  Meal meal;

  FoodOption({Key? key, required this.meal}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FoodOptionState();

}

class FoodOptionState extends State<FoodOption> {
  final constants = Constants();
  int selected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFFFCC7E),
          ),
          width: size.width/4.5,
          height: size.height/6.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: size.width/450,
                    widthFactor: size.width/400,
                    child: Image.network("https://blogladiadoresfit.com/wp-content/uploads/2021/02/avena-fitness.jpg", height: size.width/4,),
                  )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Text(widget.meal.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                  textAlign: TextAlign.start,),)
            ],
          )
      ),);
  }
}