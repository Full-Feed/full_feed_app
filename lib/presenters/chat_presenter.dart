import 'package:flutter/cupertino.dart';
import 'package:full_feed_app/models/entities/patient.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/diet_provider.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPresenter{


  List<Channel> userChannels = [];
  List<Message> lastMessages = [];
  bool messagesReady = false;
  late StreamChatClient client;
  var context;

  ChatPresenter(BuildContext _context){
    client = StreamChat.of(_context).client;
    context = _context;
    initUser();
  }

  initUser() async{
    await client.connectUser(
      User(
          id: UserSession().userId.toString(),
          extraData: {
            "name" : UserSession().userFirstName
          }
      ),
      client.devToken(UserSession().userId.toString()).rawValue,).whenComplete((){
      initChannels();
    });
  }

  initChannels(){
    if(UserSession().rol == 'p'){
      String doctorId = Provider.of<DietProvider>(context, listen: false).homePresenter.doctorByPatient.user!.userId.toString();
      userChannels.add(client.channel('messaging', id: "doctor${doctorId}patient${UserSession().userId.toString()}"));
      /*if(userChannels[0].memberCount == 0){
        userChannels[0].addMembers([ UserSession().userId.toString(), doctorId]);
      }*/
    }
    else{
      List<Patient> patientsChat = Provider.of<DietProvider>(context, listen: false).homePresenter.patientsByDoctor;
      for(int i = 0; i < patientsChat.length; i++){
        userChannels.add(client.channel('messaging', id: "doctor${UserSession().userId.toString()}patient${patientsChat[i].user!.userId.toString()}"));
      }
      /*for(int i = 0; i < userChannels.length; i++){
        if(userChannels[i].memberCount == 0){
          userChannels[i].addMembers([ UserSession().userId.toString(), patientsChat[i].user!.userId.toString()]);
        }
      }*/
    }
    getLastMessages();
  }

  getLastMessages() async{
    for(int i = 0; i < userChannels.length; i++){
      await userChannels[i].watch().then((value){
        if(value.messages.isNotEmpty){
          if(value.messages.last.user!.name != UserSession().userFirstName){
            lastMessages.add(value.messages.last);
          }
        }
        Provider.of<UserProvider>(context, listen: false).setMessages(true);
      });
      await userChannels[i].stopWatching();
    }
  }

}