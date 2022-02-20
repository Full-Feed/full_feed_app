import 'package:flutter/material.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:intl/intl.dart';

class HomeNutritionistCard extends StatefulWidget {
  const HomeNutritionistCard({Key? key}) : super(key: key);

  @override
  _HomeNutritionistCardState createState() => _HomeNutritionistCardState();
}

class _HomeNutritionistCardState extends State<HomeNutritionistCard> {
  final constants = Constants();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 2.2,
      height: size.height / 4.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: Color(constants.nutritionistCardColor),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 18, 0, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Nutricionista', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(left: size.width/30),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(
                    color: Color(0XFFD0FEC5),
                    width: 2,
                  ),
                  color: Colors.white,
                ),
                //TODO: necesita lógica si el experto tiene o no una foto, se requiere condicional de poner un ícono de usuario o imagen
                child: const Icon(Icons.account_circle, size: 30, color: Colors.grey,),
              ),),
              Padding(padding: EdgeInsets.only(left: size.width/30),
              child: const Text('Experto'),)
            ],
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Último mensaje', style: TextStyle(fontSize: 12),)
            ),
          ),
          const SizedBox(height: 10.0),
          //TODO: Esqueleto de posible chat, es necesario proveer los mensajes, el lenght del mensaje y la última hora enviada
          Container(
            width: size.width,
            height: 25.0,
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25.5)),
                color: Color(constants.homePageChatCardColor),
                boxShadow: [

                ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text('Hola ratón', style: TextStyle(fontWeight: FontWeight.w200)),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('Hora: ' + DateFormat('Hm').format(DateTime.now()), style: TextStyle(color: Color(constants.chatMessageTime), fontSize: 12))),
          )
        ],
      ),
    );
  }
}
