import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {

  List<DropdownMenuItem> datos;
  String hintText;
  dynamic initialValue;

  DropDown({Key? key, required this.hintText, required this.datos, required this.initialValue}) : super(key: key);

  @override
  State<DropDown> createState() => DropDownState();
}

class DropDownState extends State<DropDown> {

  dynamic dropdownValue;

  String value = "";
  int id = 0;

  @override
  void initState() {
    setState(() {
      value = widget.hintText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Colors.transparent,
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              elevation: 0,
              itemHeight: size.height/10,
              style: TextStyle(color: Colors.black, fontSize: size.width/25),
              hint: SizedBox(child: Text(value, style: TextStyle(color: (value == 'Sexo') ? Colors.grey : Colors.black, fontSize: size.width/25),),),
              dropdownColor: Color(0xFFF0F0F0),
              items: widget.datos,
              onChanged: (newValue) {
                setState(() {
                    value = newValue.name;
                    id = newValue.id;
                });
              },
            )
        ));
  }
}