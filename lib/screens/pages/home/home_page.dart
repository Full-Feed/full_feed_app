import 'dart:convert';


import 'package:full_feed_app/utilities/constants.dart';
import 'package:full_feed_app/screens/widgets/home/home_achievements_card.dart';
import 'package:full_feed_app/screens/widgets/home/home_diet_card.dart';
import 'package:full_feed_app/screens/widgets/home/home_nutritionist_card.dart';
import 'package:full_feed_app/screens/widgets/home/meal_body.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final constants = Constants();

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
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/json.json'),
      builder: (context, snapshot) {
        //leer el json creado
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var getData = json.decode(snapshot.data.toString());
            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text.rich(TextSpan(
                      children: [
                        const TextSpan(text: 'Bienvenido de nuevo, ', style: TextStyle(fontSize: 16)),
                        TextSpan(text: getData['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        const TextSpan(text: ' '),
                        TextSpan(text: getData['lastName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                      ])
                  ),
                ),
                const SizedBox(height: 25.0),
                HomeDietCard(
                  child: Wrap(
                    children: [
                      Meal(
                          mealType: 'Desayuno',
                          description: getData['weeklyDiet'][3][DateFormat('EEEE').format(DateTime.now()).toLowerCase()]['breakfast']
                      ),
                      Meal(
                          mealType: 'Merienda #1',
                          description: getData['weeklyDiet'][3][DateFormat('EEEE').format(DateTime.now()).toLowerCase()]['snack1']
                      ),
                      Meal(
                          mealType: 'Almuerzo',
                          description: getData['weeklyDiet'][3][DateFormat('EEEE').format(DateTime.now()).toLowerCase()]['lunch']
                      ),
                      Meal(
                          mealType: 'Merienda #2',
                          description: getData['weeklyDiet'][3][DateFormat('EEEE').format(DateTime.now()).toLowerCase()]['snack2']
                      ),
                      Meal(
                          mealType: 'Cena',
                          description: getData['weeklyDiet'][3][DateFormat('EEEE').format(DateTime.now()).toLowerCase()]['dinner']
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeNutritionistCard(),
                    HomeAchievementsCard(
                        completedDays: getData['completedDays'].toString(),
                        lostWeight: getData['lostWeight'].toString()
                    )
                  ],
                )
              ],
            );
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}


