import 'package:flutter/material.dart';
import 'package:full_feed_app/models/entities/user_session.dart';
import 'package:full_feed_app/providers/user_provider.dart';
import 'package:full_feed_app/screens/pages/chat/chat_screen.dart';
import 'package:full_feed_app/screens/pages/diet_schedule/doctor_patients_list.dart';
import 'package:full_feed_app/screens/pages/home/home_page_doctor.dart';
import 'package:full_feed_app/utilities//constants.dart';
import 'package:full_feed_app/screens/pages/diet_schedule/diet_calendar_page.dart';
import 'package:full_feed_app/screens/pages/user/user_profile_screen.dart';
import 'package:provider/provider.dart';


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
  void initState() {
    Provider.of<UserProvider>(context, listen: false).initChatPresenter(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            onTap: (index) => setState(() => currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(constants.primaryColor),
            selectedItemColor: Colors.white70,
            unselectedItemColor: Color(constants.itemSelectedColor),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: currentIndex,
            items: const [
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
        ),
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
                    child: UserSession().rol == 'p'? HomePage() : HomePageDoctor(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: UserSession().rol == 'p'? 20.0 : 5.0),
                    child: UserSession().rol == 'p'? DietCalendarPage() : DoctorPatientsList(),),
                  ChatScreen(),
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
