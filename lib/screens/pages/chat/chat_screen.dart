
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/screens/pages/chat/user_chat_page.dart';
import 'package:full_feed_app/screens/widgets/chat/chat_list_item.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../providers/diet_provider.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();
  bool isPressed = false;

  Future<void> onPressed(String firstName, String lastName, int index) async {
    final client = StreamChat.of(context).client;

    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            type: PageTransitionType.rightToLeft,
            child: UserChatPage(firstName: firstName, lastName: lastName, channel: Provider.of<UserProvider>(context, listen: false).chatPresenter.userChannels[index],)
        )
    );
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
    return SizedBox(
      width: size.width,
      height: size.height - 165,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width/16, vertical: 15.0),
        child: Provider.of<DietProvider>(context).homePresenter.patientsByDoctor.isNotEmpty || UserSession().rol == "p"?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chats', style: TextStyle(fontSize: size.width/20, color: Color(constants.primaryColor), fontWeight: FontWeight.bold),),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: size.height/70),
                  child: UserSession().rol == 'd' ? ListView(
                    children: List.generate(Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor.length, (index) =>
                        InkWell(
                          onTap: (){
                            onPressed(Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor[index].user!.firstName.toString(),
                                Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor[index].user!.lastName.toString(),
                                index);
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height/80),
                              child: ChatListItem(title: "Paciente", name: Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor[index].user!.firstName.toString(),)
                          ),
                        )
                    ),
                  ) : ListView(
                    children: [
                      InkWell(
                        onTap: (){
                          onPressed(Provider.of<DietProvider>(context, listen: false).homePresenter.doctorByPatient.user!.firstName.toString(),
                              Provider.of<DietProvider>(context, listen: false).homePresenter.doctorByPatient.user!.lastName.toString(),
                              0);
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height/80),
                            child: ChatListItem(title: "Doctor", name: Provider.of<DietProvider>(context, listen: false).homePresenter.doctorByPatient.user!.firstName.toString(),)
                        ),
                      ),
                    ],
                  )
              ),)
          ],
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.exclamationCircle, color: Colors.black26, size: size.width/10,),
              SizedBox(
                width: size.width/2,
                child: Text("Aun no tiene mensajes de sus pacientes", style: TextStyle(color: Colors.black26), textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
      )
    );
  }
}
