
import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class FoodOption extends StatefulWidget {

  String plato;
  bool selected;

  FoodOption({Key? key, required this.plato, required this.selected}) : super(key: key);

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
    var size = MediaQuery.of(context).size.width;
    var size2 = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size/50, vertical: 5),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: size2/90),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          width: size/4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: size/500,
                    widthFactor: size/500,
                    child: Image.network("https://blogladiadoresfit.com/wp-content/uploads/2021/02/avena-fitness.jpg", height: size/4,),
                  )
              ),
              Padding(padding: EdgeInsets.only(top: 10), child: Text(widget.plato, style: TextStyle(fontSize: size/35, fontWeight: FontWeight.w200),),)
            ],
          )
      ),);
  }
}