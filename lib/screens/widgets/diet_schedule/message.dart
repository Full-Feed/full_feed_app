
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants.dart';

class Message extends StatefulWidget {

  String text;
  Function yesFunction;
  Function noFunction;
  bool options;
  Message({Key? key, required this.text, required this.yesFunction, required this.noFunction, required this.options}) : super(key: key);

  @override
  MessageState createState() => MessageState();
}

class MessageState extends State<Message> {
  final constants = Constants();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(padding: EdgeInsets.symmetric(
        vertical: size.height/4, horizontal: size.width/20),
      child: SizedBox(
          width: 20,
          height: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width/2,
                child: Text(widget.text, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width/8, vertical: size.height/30),
                child: Row(
                  mainAxisAlignment: widget.options ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: (){
                          widget.yesFunction();
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(80, 80),
                          maximumSize: Size(150, 150),
                          side: BorderSide(
                              width: 2.0,
                              color: Color(constants.primaryColor)
                          ),
                          shape: CircleBorder(),
                        ),
                        child: Text(widget.options ? 'Si' : "Ok", style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold, fontSize: 16),)),
                    Visibility(
                      visible: widget.options,
                      child: OutlinedButton(
                          onPressed: (){
                            widget.noFunction();
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(80, 80),
                            maximumSize: Size(150, 150),
                            side: BorderSide(
                                width: 2.0,
                                color: Color(constants.primaryColor)
                            ),
                            shape: CircleBorder(),
                          ),
                          child: Text('No', style: TextStyle(color: Color(constants.primaryColor), fontWeight: FontWeight.bold, fontSize: 16),)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}