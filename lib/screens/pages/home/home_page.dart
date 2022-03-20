
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/screens/widgets/diet_schedule/day_plate.dart';
import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/home/home_achievements_card.dart';
import 'package:full_feed_app/screens/widgets/home/home_diet_card.dart';
import 'package:full_feed_app/screens/widgets/home/home_nutritionist_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/diet_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final constants = Constants();
  var _future;

  @override
  void initState() {
    _future = Provider.of<DietProvider>(context, listen: false).getDayMeals();
    super.initState();
  }

  int getCurrentWeek(){
    String date = DateTime.now().toString();
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);
    int weekDay = DateTime.parse(firstDay).weekday;
    DateTime testDate = DateTime.now();
    int weekOfMonth;
    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    weekDay++;
    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    return weekOfMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text.rich(TextSpan(
              children: [
                const TextSpan(text: 'Bienvenido de nuevo, ', style: TextStyle(fontSize: 16)),
                TextSpan(text: UserSession().userFirstName.contains(" ")? UserSession().userFirstName.substring(0, UserSession().userFirstName.lastIndexOf(" ")) : UserSession().userFirstName
                , style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ])
          ),
        ),
        const SizedBox(height: 25.0),
        HomeDietCard(
          child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.data == true){
                    if(Provider.of<DietProvider>(context, listen: false).homePresenter.dayMealList.isNotEmpty){
                      return Wrap(
                          children: List.generate(5, (index) =>
                              DayPlate(meal: Provider.of<DietProvider>(context, listen: false).homePresenter.dayMealList[index], selected: false,))
                      );
                    }
                    else{
                      return SizedBox(
                        height: 250,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No tiene dietas hoy', style: TextStyle(color: Colors.grey)),
                              Text('Disfrute de su dia con moderacion', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                }
                return const CircularProgressIndicator();
              }),
        ),
        const SizedBox(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeNutritionistCard(),
            HomeAchievementsCard()
          ],
        )
      ],
    );
  }
}


