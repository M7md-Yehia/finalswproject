import 'package:flutter/material.dart';
import 'package:movemate_ui/main_pages/HomePage.dart';
import 'package:movemate_ui/main_pages/Profile.dart';
import 'package:movemate_ui/main_pages/shipment_history.dart';
import 'package:movemate_ui/widgets/Location.dart';

class navigation_view extends StatefulWidget {
  const navigation_view({super.key});

  @override
  State<navigation_view> createState() => _navigation_viewState();
}

class _navigation_viewState extends State<navigation_view> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    CurrentLocationButton(),
    const ShipmentHistoryPage(),
    const Profile(
      username: '',
      email: '',
    ),
  ];

  static const Color activeColor = Color(0xFF47298c); // Custom active color
  static const Color inactiveColor = Colors.grey; // Custom inactive color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'Shipment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: navigation_view(),
  ));
}
