import 'package:flutter/material.dart';
import 'package:full_feed_app/utilities//constants.dart';
import 'package:full_feed_app/screens/pages/diet_schedule/diet_calendar_page.dart';
import 'package:full_feed_app/screens/pages/user/user_profile_screen.dart';


import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final constants = Constants();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(constants.bottomNavigationBarColor),
        selectedItemColor: Colors.white70,
        unselectedItemColor: Color(constants.itemSelectedColor),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Dieta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(constants.logoImagePath,
                        width: 40, height: 40, fit: BoxFit.contain),
                    Image.asset(constants.logoTextPath,
                        width: 70, height: 70, fit: BoxFit.contain)
                  ],
                ),
              ),
              IndexedStack(
                index: currentIndex,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: HomePage(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DietCalendarPage(),),
                  HomePage(),
                  UserProfileScreen()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
