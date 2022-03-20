import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';

class ChatListCard extends StatefulWidget {

  const ChatListCard({Key? key}) : super(key: key);

  @override
  _ChatListCardState createState() => _ChatListCardState();
}

class _ChatListCardState extends State<ChatListCard> {

  final constants = Constants();
  late DateFormat format;

  @override
  void initState() {
    format = DateFormat('EEEE HH:mm');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 3,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: Color(0xFFDFE7FC),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width/20, vertical: size.height/80),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(CupertinoIcons.chat_bubble_2_fill, color: Colors.black, size: 18,),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Conversaciones", style: TextStyle(fontWeight: FontWeight.bold),),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height/80),
              child: Provider.of<UserProvider>(context).chatPresenter.messagesReady &&Provider.of<UserProvider>(context).chatPresenter.lastMessages.isNotEmpty ?
              Column(
                children: List.generate(Provider.of<UserProvider>(context, listen: false).chatPresenter.lastMessages.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Provider.of<UserProvider>(context, listen: false).chatPresenter.lastMessages[index].user!.name,),
                            Text(format.format(Provider.of<UserProvider>(context, listen: false).chatPresenter.lastMessages[index].createdAt), style: TextStyle(fontSize: 10),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            width: size.width,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE8EEFF),
                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                            ),
                            child: Text(Provider.of<UserProvider>(context, listen: false).chatPresenter.lastMessages[index].text!),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ) :
              const Center(
                child: Text("No tiene mensajes pendientes", style: TextStyle(color: Colors.grey),),
              ),
            )
          ],
        ),
      ),
    );
  }
}