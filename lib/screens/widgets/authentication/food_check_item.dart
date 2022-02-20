import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {

  final String imagePath;
  final String title;
  final int color;
  const FoodItem({Key? key, required this.imagePath, required this.title,
    required this.color}) : super(key: key);

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {

  List<bool> isSelected = List.generate(1, (_) => false);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Color(widget.color),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height/120),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(widget.title),
            ),),
          Align(
              alignment: Alignment.center,
              child: Image.asset(widget.imagePath, fit: BoxFit.contain, width: 50, height: 50)),
          Padding(
            padding: EdgeInsets.only(bottom: size.height/120, right: size.height/120),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ToggleButtons(
                constraints: const BoxConstraints(minHeight: 15, minWidth: 15),
                children: const [
                  Icon(Icons.check, size: 15)
                ],
                isSelected: isSelected,
                onPressed: (int index) {
                  setState((){
                    isSelected[index] = !isSelected[index];
                  });
                },
                color: Colors.transparent,
                selectedColor: Colors.green,
                borderRadius: BorderRadius.circular(50),
                borderWidth: 2,
                borderColor: Colors.white,
              ),
            ),)
        ],
      ),
    );
  }
}
