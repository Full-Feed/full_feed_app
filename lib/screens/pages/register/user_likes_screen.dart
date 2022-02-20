import 'package:flutter/material.dart';
import 'package:full_feed_app/presenters/register_presenter.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/authentication/food_check_item.dart';


class UserLikesScreen extends StatefulWidget {
  RegisterPresenter presenter;
  UserLikesScreen({Key? key, required this.presenter}) : super(key: key);

  @override
  _UserLikesScreenState createState() => _UserLikesScreenState();
}

class _UserLikesScreenState extends State<UserLikesScreen> with
    AutomaticKeepAliveClientMixin{

  final constants = Constants();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width/15, vertical: size.height/50),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Selecciona que comidas te gustan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),)),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Carnes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                height: 260,
                width: 280,
                child: GridView.count(
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 3,
                  children: List.generate(widget.presenter.meats.length, (index) =>
                      FoodItem(
                        title: widget.presenter.meats[index].name!,
                        imagePath: 'assets/1.png',
                        color: constants.proteinItemColor,
                      ),),
                ),
              ),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Cereales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                height: 260,
                width: 280,
                child: GridView.count(
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 3,
                  children: List.generate(widget.presenter.cereals.length, (index) =>
                      FoodItem(
                        title: widget.presenter.cereals[index].name!,
                        imagePath: 'assets/1.png',
                        color: constants.proteinItemColor,
                      ),),
                ),
              ),),
            Padding(
              padding: EdgeInsets.only(left: size.width/10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Otros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height/50),
              child: Container(
                height: 260,
                width: 280,
                child: GridView.count(
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 3,
                  children: List.generate(widget.presenter.others.length, (index) =>
                      FoodItem(
                        title: widget.presenter.others[index].name!,
                        imagePath: 'assets/1.png',
                        color: constants.proteinItemColor,
                      ),),
                ),
              ),),
          ],
        ),
      ),
    ) ;
  }
}
