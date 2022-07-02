import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trekkers_project/controllers/auth_controller.dart';
import 'package:trekkers_project/screens/dashboard/add/add_screen.dart';
import 'package:trekkers_project/screens/dashboard/event/event_screen.dart';
import 'package:trekkers_project/screens/screens.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => DashboardScreen(), settings: RouteSettings(name: routeName));
  }
  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
  HomeScreen(),
  PlaceScreen(),
  EventScreen(),
  GuideScreen(),
  ShoppingScreen(),
  ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
  
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Event ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: "Guide",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping',
          ),
       
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
       
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}


