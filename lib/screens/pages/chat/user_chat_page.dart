import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/models/entities/patient.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class UserChatPage extends StatefulWidget {

  String firstName;
  String lastName;
  Channel channel;
  UserChatPage({Key? key, required this.firstName, required this.lastName, required this.channel}) : super(key: key);

  @override
  UserChatPageState createState() => UserChatPageState();
}

class UserChatPageState extends State<UserChatPage> with
    AutomaticKeepAliveClientMixin{

  late StreamChatClient client;
  final constants = Constants();
  bool isPressed = false;
  late Channel channel;


  @override
  void initState() {
    channel = widget.channel;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamChannel(
        channel: channel,
        child: Container(
            margin: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 20.0),
            padding: EdgeInsets.only(bottom: size.height/80),
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height/11,
                    decoration: BoxDecoration(
                        color: Color(constants.primaryColor)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width/20, vertical: size.height/80),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width/30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.white
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: size.width/20, vertical: size.height/85),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.lastName, style: TextStyle(color: Colors.white, fontSize: size.width/35),),
                                    Text(widget.firstName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: size.width/25),)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height/10),
                      child: Column(
                        children: [
                          Expanded(
                            child: MessageListView(),
                          ),
                          MessageInput(

                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
